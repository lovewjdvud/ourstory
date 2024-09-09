//
//  MainTabFeature.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/2/24.
//

import SwiftUI
import ComposableArchitecture

struct MainTabFeature: Reducer {
    struct State: Equatable {
        var boardState = BoardFeature.State()
        var profileState = ProfileFeature.State()
    }
    
    @CasePathable
    @dynamicMemberLookup
    enum Action: Equatable {
        case board(BoardFeature.Action)
        case profile(ProfileFeature.Action)
    }
    
    init() {
        print("MainTabFeature init \(UserDefaultsManager.shared.loadUserProfile()?.email ?? "")")
    }
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .board, .profile:
                return .none
            }
        }
        Scope(state: \.boardState, action: \.board) {
            BoardFeature()
        }
        
        Scope(state: \.profileState, action: \.profile) {
            ProfileFeature()
        }
    }
}
