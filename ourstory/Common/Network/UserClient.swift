//
//  AuthClient.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/2/24.
//

import Foundation
import ComposableArchitecture
import Dependencies

struct UserClient {
    var test: @Sendable (SignInRequestModel) async throws -> JwtResponseModel?
    var signIn: @Sendable (SignInRequestModel) async throws -> SignInResponseModel?
    var signUp: @Sendable (SignUpRequestModel) async throws -> SignUpResponseModel?
    var profileUpdate: @Sendable (UserProfileModel) async throws -> UserProfileModel?
    var fetchProfileInfo: @Sendable (Int) async throws -> UserProfileModel?
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
            signIn:  { request_model in
                try await networkManager.request("/user/sign-in",
                                                 method: .post,
                                                 queryItems: [],
                                                 body: request_model,
                                                 requiresAuth: false)
            },
            signUp: { request_data in
                
                try await networkManager.request("/user/join",
                                                 method: .post,
                                                 queryItems: [],
                                                 body: request_data,
                                                 requiresAuth: true)
            },
            profileUpdate: { request in
                try await networkManager.request("/user/info/update/\(request.data?.id ?? -1)",
                                                 method: .put,
                                                 queryItems: [],
                                                 body: nil,
                                                 requiresAuth: true)
            },
            fetchProfileInfo: { user_id in
                try await networkManager.request("/user/info/\(user_id)",
                                                 method: .get,
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
