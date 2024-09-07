//
//  AuthClient.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/2/24.
//

import Foundation
import ComposableArchitecture
import Dependencies

struct AuthClient {
    var test: @Sendable (SignInRequestModel) async throws -> JwtResponseModel?
    var signIn: @Sendable (SignInRequestModel) async throws -> SignInResponseModel?
    var signUp: @Sendable (SignUpRequestModel) async throws -> SignUpResponseModel?
    var profileUpdate: @Sendable (UserProfileModel) async throws -> UserProfileModel?
}

extension AuthClient: DependencyKey {
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
                                                 requiresAuth: false)
            },
            profileUpdate: { request in
                try await networkManager.request("/user/info/update/\(request.id)",
                                                 method: .put,
                                                 queryItems: [],
                                                 body: nil,
                                                 requiresAuth: false)
            }
        )
    }()
    
}

extension DependencyValues {
    var authClient: AuthClient {
        get { self[AuthClient.self] }
        set { self[AuthClient.self] = newValue }
    }
}
//
//YourProject/
//│
//├── Features/
//│   ├── Auth/
//│   │   ├── Models/
//│   │   │   ├── User.swift
//│   │   │   └── SignUpModel.swift
//│   │   ├── Reducers/
//│   │   │   ├── AuthReducer.swift
//│   │   │   ├── LoginReducer.swift
//│   │   │   └── SignUpReducer.swift
//│   │   └── Views/
//│   │       ├── LoginView.swift
//│   │       └── SignUpView.swift
//│   │
//│   ├── Profile/
//│   │   ├── Models/
//│   │   │   └── UserProfile.swift
//│   │   ├── Reducers/
//│   │   │   └── ProfileReducer.swift
//│   │   └── Views/
//│   │       └── ProfileView.swift
//│   │
//│   └── Notes/
//│       ├── Models/
//│       │   └── Note.swift
//│       ├── Reducers/
//│       │   ├── NotesReducer.swift
//│       │   └── NoteDetailReducer.swift
//│       └── Views/
//│           ├── NotesListView.swift
//│           └── NoteDetailView.swift
//│
//├── Core/
//│   ├── Network/
//│   │   ├── NetworkManager.swift
//│   │   ├── APIEndpoints.swift
//│   │   └── NetworkError.swift
//│   └── Utilities/
//│       └── DateFormatter.swift
//│
//├── Dependencies/
//│   ├── AuthClient.swift
//│   ├── ProfileClient.swift
//│   └── NotesClient.swift
//│
//└── App.swift
