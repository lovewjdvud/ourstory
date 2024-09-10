//
//  AppFeature.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/2/24.
//

import Foundation
import ComposableArchitecture

struct AppFeature: Reducer {
    
    struct State: Equatable {
        var isProgress: Bool = false
        
        var isLoggedIn: Bool = false
        var isLoggedIn2: Bool = false
        
        var mainTab = MainTabFeature.State()
        var authTab = AuthFeature.State()
    }
    
    @CasePathable
    @dynamicMemberLookup
    enum Action: Equatable {
        case checkLogin
        case loginChecked(Bool)
        
        case mainTab(MainTabFeature.Action)
        case authTab(AuthFeature.Action)
    }
    
    init() {
        print("AppFeature init")
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .checkLogin:
                let userInfoExists = UserDefaultsManager.shared.loadUserProfile() != nil
                return .send(.loginChecked(userInfoExists))
                
            case .loginChecked(let isLoggedIn):
                print("AppFeature loginChecked isLoggedIn \(isLoggedIn)")
                if isLoggedIn  {
//                    state.authTab.isProgress = true
                    return .send(.authTab(.signGoogleButtonTapped))
                }
                
                return .none
                
            case .mainTab:
                return .none
                
            case .authTab(let authAction):
                // 만약 authTab에서 로그인 성공 액션이 발생하면 업데이트 됨
                if case .navigateToMainTab = authAction {
                        state.isLoggedIn = true
//                        state.isLoggedIn = true
                    }
                
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
