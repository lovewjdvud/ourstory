//
//  AppFeature.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/2/24.
//

import Foundation
import ComposableArchitecture
import ComposableArchitecture

struct AppFeature: Reducer {
    
    struct State: Equatable {
        var isLoggedIn: Bool = false
        var isLoggedIn2: Bool = false
        var mainTab = MainTabFeature.State()
        var authTab = AuthFeature.State()
    }
    
    @CasePathable
    @dynamicMemberLookup
    enum Action: Equatable {
        case checkToken
        case tokenChecked(Bool)
        
        case mainTab(MainTabFeature.Action)
        case authTab(AuthFeature.Action)
    }
    
    init() {
        print("AppFeature init")
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .checkToken:
                let tokenExists = AuthManager.shared.getToken() != nil
                return .send(.tokenChecked(tokenExists))
                
            case .tokenChecked(let isLoggedIn):
                state.isLoggedIn = isLoggedIn
                return .none
                
            case .mainTab:
                return .none
                
            case .authTab:
                return .none
            }
        }
        
        Scope(state: \.mainTab, action: \.mainTab) {
            MainTabFeature()
        }
        
        Scope(state: \.authTab, action: \.authTab) {
            AuthFeature()
        }
    }
    
}

//
//ourstoryApp
//│
//├── App
//│   ├── Config
//│   │   ├── AppConfig.swift
//│   │   └── Environment.swift
//│   └── Main
//│       └── ContentView.swift
//│
//├── Core
//│   ├── Utilities
//│   │   ├── AuthManager.swift
//│   │   ├── NetworkManager.swift
//│   │   └── CommonError.swift
//│   ├── Models
//│   │   ├── Auth
//│   │   │   ├── AuthRequest.swift
//│   │   │   └── AuthResponse.swift
//│   │   ├── Profile
//│   │   │   ├── ProfileRequest.swift
//│   │   │   └── ProfileResponse.swift
//│   │   └── Common
//│   │       ├── Pagination.swift
//│   │       └── ResultWrapper.swift
//│   └── Network
//│       ├── AuthClient.swift
//│       ├── ChatRoomClient.swift
//│       ├── BoardClient.swift
//│       ├── ProfileClient.swift
//│       └── CommonClient.swift
//│
//├── Features
//│   ├── Auth
//│   │   ├── LoginView.swift
//│   │   ├── SignUpView.swift
//│   │   └── AuthFeature.swift
//│   │
//│   ├── Profile
//│   │   ├── ProfileView.swift
//│   │   ├── EditProfileView.swift
//│   │   └── ProfileFeature.swift
//│   │
//│   ├── Board
//│   │   ├── BoardListView.swift
//│   │   ├── BoardDetailView.swift
//│   │   └── BoardFeature.swift
//│   │
//│   ├── Comment
//│   │   ├── CommentListView.swift
//│   │   ├── CommentDetailView.swift
//│   │   └── CommentFeature.swift
//│   │
//│   ├── ChatRoom
//│   │   ├── ChatListView.swift
//│   │   ├── ChatDetailView.swift
//│   │   └── ChatRoomFeature.swift
//│   │
//│   └── AppFeature.swift
//│
//└── Resources
//    ├── Assets.xcassets
//    └── Localization
//        ├── en.lproj
//        │   └── Localizable.strings
//        └── ko.lproj
//            └── Localizable.strings
