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
        var isProgress: Bool = false
        var isSigningUp : Bool = false
//        var isSignin : Bool = false
        var user: UserProfileModel?
        
//        var googleAuthManager = GoogleAuthManager()
        
        // Equatable 프로토콜 준수 구현
//        static func == (lhs: State, rhs: State) -> Bool {
//              return lhs.isSigningUp == rhs.isSigningUp &&
//                     lhs.user == rhs.user &&
//                     lhs.error == rhs.error
//              // googleAuthManager는 비교에서 제외됩니다.
//        }
        
        var error: String?
    }
    @CasePathable
    @dynamicMemberLookup
    enum Action: BindableAction,Equatable {
        case binding(BindingAction<State>)
        
        
        case signIn(String,String)
        case signInResponse(SignInResponseModel?,String,String)
        
        case signGoogleButtonTapped
        case signKakaoButtonTapped
        case signAppleButtonTapped
        
        case signUp(String,String)
        case signUpResponse(SignUpResponseModel,String,String)

        case navigateToMainTab
        
        case fetchProfileInfo(Int)
        case fetchProfileInfoResponse(UserProfileModel?)
        
        case cancelFail(CancelID,String)
    }
    
    @Dependency(\.userClient) var userClient
    
    enum CancelID {
        case signUp
        case signIn
        case googleSignIn
        case fetchProfileInfo
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
                print("AuthFeature Action signIn 진입  email = \(email), name = \(name)")
                return .run { send in
                    do {
                       
                         let signInRequestModel = SignInRequestModel(email: email)
                        
//                         // 7초 타임아웃 설정
//                          let signInResult = try await withThrowingTaskGroup(of: SignInResponseModel.self) { group in
//                              
//                              // 로그인 요청 task
//                              group.addTask {
//                                  return try await userClient.signIn(signInRequestModel)
//                              }
//                              
////                              // 7초 후 타임아웃 처리 task
////                              group.addTask {
////                                  try await Task.sleep(nanoseconds: 20_000_000_000) // 7초 대기
////                                  throw NetworkError.timeout(message: "Error Message : 시간초과") // 타임아웃 에러 발생
////                              }
//                              
//                              // 첫 번째 완료된 Task의 값을 반환
//                              for try await result in group {
//                                  return result // 첫 번째 Task 결과 반환
//                              }
//                              
//                              throw NetworkError.unknown(message: "Error Message : 값이 없음") // 이 줄이 실행될 경우 예상치 못한 상황이므로 에러 처리
//                          }


                        let signInResult = try await userClient.signIn(signInRequestModel)
                        await send(.signInResponse(signInResult,email,name))
                    } catch(let error as NetworkError) {
                        await send(.cancelFail(.signIn, " signIn fail \(error.localizedDescription)"))
                    }
                        
                }
                .cancellable(id: CancelID.signIn)
                
            case .signInResponse(let signInResult,let email,let name):
                print("AuthFeature Action signInResponse success 진입")
                return .run { send in
                    switch signInResult?.result_cd {
                    case 20 : // 로그인 성공
                        print("AuthFeature Action signIn result : 로그인 성공")
                        if let token = signInResult?.data?.accessToken ,
                           let user_id = signInResult?.data?.user_id {
                            
                            AuthManager.shared.setToken(token)
                            await send(.fetchProfileInfo(user_id))
                            
                        } else {
                            await send(.navigateToMainTab)
                            print("AuthFeature Action signIn result : 로그인 성공 - 토큰이 없음")
                        }
                        
                        //                            await send(.signInResponse(.success(signInResult)))
                        break
                        
                    case 411: // 아이디가 존재하지 않을 때
                        print("AuthFeature Action signIn result : 아이디가 존재하지 않음")
                        await send(.signUp(email, name))
                        break
                        
                    case 40: // 로그인 실패
                        print("AuthFeature Action signIn result : 로그인 실패")
                        await send(.cancelFail(.signIn, " 로그인 실패 "))
                        break
                    default :
                        break
                    }
                }
            
//            case .signInResponse(.failure(let error)):
//              
//                state.error = error.localizedDescription
//                return .none
                
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
                        print("AuthFeature Action signUp result 1")
                        let signUpResultModel = try await userClient.signUp(signUpRequestModel)
                        print("AuthFeature Action signUp result 2")
                        if let signUpResult = signUpResultModel {
                        
                            
                            await send(.signUpResponse(signUpResult,email,name))
                        }
                      
                    } catch(let error as NetworkError) {
                       
                        await send(.cancelFail(.signUp, " signUp fail Error \(error.description)"))
                    }
                    
                }
                .cancellable(id: CancelID.signUp)
                
            case .signUpResponse(let signUpResult,let email,let name):
//                state.isSigningUp = false
//                 state.isProgress = false
                print("AuthFeature Action signUpResponse : state code \(signUpResult.result_cd)")
                return .run { send in
                    switch signUpResult.result_cd {
                        
                    case 20:
                        print("AuthFeature Action signUp result : 회원가입 성공")
                        await send(.signIn(signUpResult.data?.email ?? "",signUpResult.data?.name ?? ""))
                        break
                    case 421 :
                        print("AuthFeature Action signUp result : 회원가입 아이디가 이미 존재합니다 ")
                        await send(.signIn(email,name))
                        break
                    default:
                        print("AuthFeature Action signUp result default \(signUpResult.result_cd) ")
                        await send(.cancelFail(.signUp, " signIn fail \(signUpResult.result_msg ?? "")"))
                        break
                    }
                }
        
                
                
            // MARK: 구글,카카오,애픓 로그인 버튼
            case .signGoogleButtonTapped:
               
                state.isProgress = true
                print("AuthFeature Action signGoogleButtonTapped \(state.isProgress)")
              //  return .none
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
                
                
            // MARK: 유저 정보 요청
            case .fetchProfileInfo(let user_id):
                print("AuthFeature Action fetchProfileInfo 진입")
                return .run { send in
                    do {
                        let result = try await userClient.fetchProfileInfo(user_id)
                        await send(.fetchProfileInfoResponse(result))
                        
                    } catch(let error) {
                        await send(.cancelFail(.fetchProfileInfo, "유저 정보 요청 실패 error msg \(error.localizedDescription)"))
                    }
                }
                .cancellable(id: CancelID.fetchProfileInfo)
                
            case .fetchProfileInfoResponse(let userProfileInfo):
                print("AuthFeature Action fetchProfileInfo 진입 result_cd \(userProfileInfo?.result_cd ?? -1)")
                state.isProgress = false
                return .run { send in
                    switch userProfileInfo?.result_cd {
                    case 20:
                        if let userProfileInfo = userProfileInfo?.data {
                            UserDefaultsManager.shared.saveUserProfile(userProfileInfo)
                        }
                        await send(.navigateToMainTab)
//                            await send(.signInResponse(result))
                        break
                    default:
                        await send(.cancelFail(.fetchProfileInfo, "AuthFeature fetchProfileInfo 프로필 정보 실패"))
                        await send(.navigateToMainTab)
                        break
                    
                    }
                }
                
    
            case.navigateToMainTab:
                return .none
                
            case .cancelFail(let cancelEnum ,let result_msg):
                print("AuthFeature Action cancelFail msg = \(result_msg), cancel \(cancelEnum)")
                state.isProgress = false
                return .cancel(id: cancelEnum)
            }
        }
    }
}
