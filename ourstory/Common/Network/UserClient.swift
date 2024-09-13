//
//  AuthClient.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/2/24.
//

import Foundation
import ComposableArchitecture
import Dependencies
import UIKit

struct UserClient {
    var test: @Sendable (SignInRequestModel) async throws -> JwtResponseModel?
    var signIn: @Sendable (SignInRequestModel) async throws -> SignInResponseModel?
    var signUp: @Sendable (SignUpRequestModel) async throws -> SignUpResponseModel?
    var profileUpdate: @Sendable (UserProfileModel) async throws -> UserProfileModel?
    var fetchProfileInfo: @Sendable (Int) async throws -> UserProfileModel?
//    var profilImageUpload: @Sendable ([UIImage]) async throws -> BaseModel?
    var profilImageDelete: @Sendable (Int) async throws -> BaseModel?
}

extension UserClient: DependencyKey {
    static let liveValue: Self = {
        let networkManager = NetworkManager(baseURL: Config.baseURL)
        
        return Self(
            
            test:  {  request_model in
                try await networkManager.request("/user/test",
                                                 method: .get,
                                                 queryItems: [],
                                                 body: request_model,
                                                 requiresAuth: false)
            },
            
            // 로그인 요청
            signIn:  { request_model in
                try await networkManager.request("/user/sign-in",
                                                 method: .post,
                                                 queryItems: [],
                                                 body: request_model,
                                                 requiresAuth: false)
            },
//            print("userCilent 회원가입 요청")
            // 회원가입 요청
            signUp: { request_data in
               
                try await networkManager.request("/user/join",
                                                 method: .post,
                                                 queryItems: [],
                                                 body: request_data,
                                                 requiresAuth: false)
            },
            // 프로필 업데이트
            profileUpdate: { request in
                try await networkManager.request("/user/info/update/\(request.data?.id ?? -1)",
                                                 method: .put,
                                                 queryItems: [],
                                                 body: nil,
                                                 requiresAuth: true)
            }, 
            // 프로필 정보 요청
            fetchProfileInfo: { user_id in
                try await networkManager.request("/user/info/\(user_id)",
                                                 method: .get,
                                                 queryItems: [],
                                                 body: nil,
                                                 requiresAuth: true)
            },
            
            
//            // 프로필 사진 요청
//            profilImageUpload: { request in
//                try await networkManager.uploadMultipartFormData(<#T##endpoint: String##String#>,
//                                                                 parameters: <#T##[String : String]#>,
//                                                                 fileData: <#T##[String : (data: Data, fileName: String, mimeType: String)]#>)
//            },
            
//            guard let image = imageView.image,
//                          let imageData = image.jpegData(compressionQuality: 0.8) else {
//                        print("이미지를 준비하는 데 실패했습니다.")
//                        return
//                    }
//                    
//                    Task {
//                        do {
//                            let parameters = ["description": "My awesome photo"]
//                            let fileData = ["image": (data: imageData, fileName: "photo.jpg", mimeType: "image/jpeg")]
//                            
//                            let response: ImageUploadResponse = try await networkManager.uploadMultipartFormData(
//                                "/upload",
//                                parameters: parameters,
//                                fileData: fileData
//                            )
            
            
            // 프로필 사진 삭제
            profilImageDelete: { fild_id in
                try await networkManager.request("/user/info/\(fild_id)",
                                                 method: .delete,
                                                 queryItems: [],
                                                 body: nil,
                                                 requiresAuth: true)
            }
            
            
        )
    }()
    
}

extension DependencyValues {
    var userClient: UserClient {
        get { self[UserClient.self] }
        set { self[UserClient.self] = newValue }
    }
}
