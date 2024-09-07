//
//  AuthReducer.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/2/24.
//

import Foundation
import ComposableArchitecture
import GoogleSignIn
import SwiftUI

struct AuthFeature: Reducer {
    
    struct State: Equatable {
        var isSigningUp : Bool = false
        var isSignin : Bool = false
        var user: UserProfileModel?
        
        var googleAuthManager = GoogleAuthManager()
        
        // Equatable 프로토콜 준수 구현
        static func == (lhs: State, rhs: State) -> Bool {
              return lhs.isSigningUp == rhs.isSigningUp &&
                     lhs.user == rhs.user &&
                     lhs.error == rhs.error
              // googleAuthManager는 비교에서 제외됩니다.
        }
        
        var error: String?
    }
    
    enum Action: BindableAction,Equatable {
        case binding(BindingAction<State>)
        case signIn(String,String)
        case signUp(String,String)
        
        case signGoogleButtonTapped
        case signKakaoButtonTapped
        case signAppleButtonTapped
        
        
        case signUpResponse(TaskResult<SignUpResponseModel>)
        case signInResponse(TaskResult<SignInResponseModel?>)

        case cancelFail(CancelID,String)
    }
    
    @Dependency(\.authClient) var authClient
    
    enum CancelID {
        case signUp
        case signIn
        case googleSignIn
    }
    
    init() {
        print("AuthFeature init")
    }
    
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case.binding :
                return .none
            
            // MARK: 로그인 요청,응답 및 로그아웃
            case .signIn(let email, let name):
                print("AuthFeature Action signIn 진입")
                return .run { send in
                    do {
                        print("AuthFeature Action signIn 네트워크 시작 \(email)")
                        let signInRequestModel = SignInRequestModel(email: email)
                        let signInResult = try await authClient.signIn(signInRequestModel)
                        print("AuthFeature Action signIn -> \(String(describing: signInResult?.detail_msg ?? "")), state code \(signInResult?.result_cd ?? -1)")
                        switch signInResult?.result_cd {
                        case 20 : // 로그인 성공
                            print("AuthFeature Action signIn result : 로그인 성공")
                            await send(.signInResponse(.success(signInResult)))
                            break
                            
                        case 411: // 아이디가 존재하지 않을 때
                            print("AuthFeature Action signIn result : 아이디가 존재하지 않음")
                            await send(.signUp(email, name))
                            break
                            
                        case 40: // 로그인 실패
                            print("AuthFeature Action signIn result : 로그인 실패")
                            break
                        default :
                            break
                        }
                        
                   
                        
                    } catch(let error as NetworkError) {
                        print("AuthFeature Action signIn fail \(error.localizedDescription)")
                        await send(.cancelFail(.signIn, " signIn fail \(error.localizedDescription)"))
                    }
                        
//                    print("AuthFeature Action signIn \(signInResult?.result_msg ?? "")")
                }
                .cancellable(id: CancelID.signIn)
                
            case .signInResponse(.success(let result)):
                print("AuthFeature Action signInResponse success 진입")
                state.isSignin = true
                return .none
                
            case .signInResponse(.failure(let error)):
                state.isSignin = false
                state.error = error.localizedDescription
                return .none
                
            // MARK: 회원가입 요청,응답 및 로그아웃
            case .signUp(let email, let name):
                print("AuthFeature Action signUp 진입 \(email) \(name)")
                return .run { send in
                    do {
                        let signUpRequestModel = SignUpRequestModel(email: email,
                                                                    name: name, 
                                                                    password: nil,
                                                                    nickname: nil,
                                                                    phoneNumber: nil,
                                                                    profileImageUrl: nil,
                                                                    snsType: nil)
                        let signUpResult = try await authClient.signUp(signUpRequestModel)
                        print("AuthFeature Action signUp result : state code \(signUpResult?.result_cd ?? -1)")
                        switch signUpResult?.result_cd {
                            
                        case 20:
                            print("AuthFeature Action signUp result : 회원가입 성공")
                            await send(.signIn(signUpResult?.data?.email ?? "",signUpResult?.data?.name ?? ""))
                            break
                        case 421 :
                            print("AuthFeature Action signUp result : 회원가입 아이디가 이미 존재합니다 ")
                            await send(.signIn(email,name))
                            break
                        default:
                            print("AuthFeature Action signUp result default \(signUpResult?.result_cd ?? -1) ")
                            break
                        }
                        print("AuthFeature Action signUp result -> \(signUpResult?.result_msg ?? "") ")
                    } catch(let error as NetworkError) {
                        print("AuthFeature Action signUp result : fail \(error.localizedDescription)")
                    }
                    
                }
                .cancellable(id: CancelID.signUp)
                
            case .signUpResponse(.success(let result)):
//                state.isSigningUp = false
//                state.user = user
                return .none
            
           
            case .signUpResponse(.failure(let error)):
                state.isSigningUp = false
                state.error = error.localizedDescription
                return .none
                
    
            case .cancelFail(let cancelEnum ,let result_msg):
                print("AuthFeature Action cancelFail msg = \(result_msg), cancel \(cancelEnum)")
                return .cancel(id: cancelEnum)
                
            // MARK: 구글,카카오,애픓 로그인 버튼
            case .signGoogleButtonTapped:
                print("AuthFeature Action signGoogleButtonTapped")
                return .run { send in
                        let result = await GoogleAuthManager().signIn()
                       switch result {
                       case .success(let userInfo):
                           print("AuthFeature Action signGoogleButtonTapped Google Success")
                           await send(.signIn(userInfo.email,userInfo.name))
                       case .failure(let error):
                           await send(.cancelFail(.googleSignIn,"로그인 실패 : \(error)"))
                       }
                }

               
            case .signKakaoButtonTapped:
                return .none

                
            case .signAppleButtonTapped:
                return .none
                

            }
        }
    }
}

//이 Reducer는 다음과 같은 기능을 수행합니다:
//State는 로딩 상태, 사용자 정보, 오류 메시지를 관리합니다.
//Action은 회원가입 버튼 탭과 회원가입 응답을 처리합니다.
//reduce 함수에서:
//signUpButtonTapped 액션이 발생하면 로딩 상태를 true로 설정하고 authClient.signUp을 호출합니다.
//signUpResponse 액션에서는 성공 또는 실패에 따라 상태를 업데이트합니다.
//이 Reducer를 사용하려면 다음과 같이 Store를 생성하고 SwiftUI View에 연결할 수 있습니다:
//swift
//struct AuthView: View {
//    let store: StoreOf<AuthFeature>
//
//    var body: some View {
//        WithViewStore(self.store, observe: { $0 }) { viewStore in
//            VStack {
//                if viewStore.isLoading {
//                    ProgressView()
//                } else if let user = viewStore.user {
//                    Text("Welcome, \(user.name)")
//                } else {
//                    Button("Sign Up") {
//                        viewStore.send(.signUpButtonTapped)
//                    }
//                }
//                
//                if let error = viewStore.error {
//                    Text(error)
//                        .foregroundColor(.red)
//                }
//            }
//        }
//    }
//}
