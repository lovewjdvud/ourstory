//import Foundation
//import GoogleSignIn
//import Firebase
//import FirebaseAuth
//import SwiftUI
//
//typealias GoogleCompletion = (_ success: Bool, _ resultGoogleEmail: String, _ resultGoogleUserName: String) -> Void
//
//class GoogleAuthManager {
//    // 로그인 상태 정의
//    enum SignInState {
//        case signedIn
//        case signedOut
//    }
//
//    private var googleLoginCompletion: GoogleCompletion?
//
//    // 구글 로그인 관련 데이터
//     var googleEmail: String? = ""
//     var googleUserName: String? = ""
//
//    // 로그인 처리 함수
//    func signIn(completion: @escaping GoogleCompletion) {
//        print("GoogleAuthManager google sign in init ")
//        self.googleLoginCompletion = completion
//
//        // 이전 로그인 확인
//        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
//            GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
//              
//                self.authenticateUser(for: user, with: error)
//            }
//        } else {
//            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
//
//            GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)
//
//            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//                  let rootViewController = windowScene.windows.first?.rootViewController else { return }
//
//            GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) {  result, error in
//       
//                self.authenticateUser(for: result?.user, with: error)
//            }
//       }
//    }
//
//    // 사용자 인증 함수
//    private func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {
//        print("GoogleAuthManager authenticateUser init")
//        
//        if let error = error {
//            print("인증 실패: \(error.localizedDescription)")
//            googleLoginCompletion?(false, "", "")
//            return
//        }
//        
//        guard let user = user else {
//            googleLoginCompletion?(false, "", "")
//            return
//        }
//        
//        guard let idToken = user.idToken?.tokenString else { return }
//        let accessToken = user.accessToken.tokenString
//        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
//        
//        // Firebase에 로그인
//        Auth.auth().signIn(with: credential) {  (_, error) in
//            // guard let self = self else { return } // self 안전하게 언랩핑
//            if let error = error {
//                if let errCode = AuthErrorCode(rawValue: error._code) {
//                            switch errCode {
//                            case .networkError:
//                                print("네트워크 오류 발생")
//                            case .userNotFound:
//                                print("사용자를 찾을 수 없습니다.")
//                            default:
//                                print("알 수 없는 오류: \(error.localizedDescription)")
//                            }
//                }
//                self.googleLoginCompletion?(false, "", "")
//            } else {
//                self.googleEmail = user.profile?.email
//                self.googleUserName = user.profile?.name
//                self.googleLoginCompletion?(true, user.profile?.email ?? "", user.profile?.name ?? "")
//            }
//        }
//    }
//
//    // 로그아웃 함수
//    func signOut(completion: @escaping (_ success: Bool) -> ()) {
//        GIDSignIn.sharedInstance.signOut()
//        do {
//            try Auth.auth().signOut()
//            completion(true)
//        } catch {
//            print("로그아웃 실패: \(error.localizedDescription)")
//            completion(false)
//        }
//    }
//}
// Core/Utilities/GoogleAuthManager.swift

import Foundation
import GoogleSignIn
import Firebase
import FirebaseAuth
import SwiftUI

class GoogleAuthManager: ObservableObject {
    @Published var state: SignInState = .signedOut
//    @Published var googleEmail: String?
//    @Published var googleUserName: String?

    enum SignInState {
        case signedIn
        case signedOut
    }

    func signIn() async -> Result<(email: String, name: String), Error> {
        await withCheckedContinuation { continuation in
            signInInternal { success, email, name, error in
                if success, let email = email, let name = name {
                    continuation.resume(returning: .success((email: email, name: name)))
                } else {
                    continuation.resume(returning: .failure(error ?? NSError(domain: "GoogleAuthManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown error occurred"])))
                }
            }
        }
    }

    private func signInInternal(completion: @escaping (Bool, String?, String?, Error?) -> Void) {
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [weak self] user, error in
                self?.authenticateUser(for: user, with: error, completion: completion)
            }
        } else {
            guard let clientID = FirebaseApp.app()?.options.clientID,
                  let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let rootViewController = windowScene.windows.first?.rootViewController else {
                completion(false, nil, nil, NSError(domain: "GoogleAuthManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to get root view controller"]))
                return
            }

            let config = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = config

            GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [weak self] result, error in
                self?.authenticateUser(for: result?.user, with: error, completion: completion)
            }
        }
    }

    private func authenticateUser(for user: GIDGoogleUser?, with error: Error?, completion: @escaping (Bool, String?, String?, Error?) -> Void) {
        if let error = error {
            completion(false, nil, nil, error)
            return
        }

        guard let user = user,
              let idToken = user.idToken?.tokenString else {
            completion(false, nil, nil, NSError(domain: "GoogleAuthManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to get user information"]))
            return
        }

        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)

        Auth.auth().signIn(with: credential) { [weak self] _, error in
            if let error = error {
                completion(false, nil, nil, error)
            } else {
                self?.state = .signedIn
                let googleEmail = user.profile?.email
                let googleUserName = user.profile?.name
                completion(true, user.profile?.email, user.profile?.name, nil)
            }
        }
    }

    func signOut() async -> Bool {
        do {
            GIDSignIn.sharedInstance.signOut()
            try Auth.auth().signOut()
            state = .signedOut
            return true
        } catch {
            print("로그아웃 실패: \(error.localizedDescription)")
            return false
        }
    }
}
