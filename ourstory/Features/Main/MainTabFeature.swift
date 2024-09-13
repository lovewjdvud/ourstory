//
//  MainTabFeature.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/2/24.
//

import SwiftUI
import ComposableArchitecture

struct MainTabFeature: Reducer {
    
    @ObservableState
    struct State: Equatable {
        
        var boardState = BoardFeature.State()
        var profileState = ProfileFeature.State()
        var selectedTab: Page = .board // 선택된 탭
    
        var isMainTab : Bool = true
    }
 
    @CasePathable
    @dynamicMemberLookup
    enum Action: Equatable {
     
        case board(BoardFeature.Action)
        case profile(ProfileFeature.Action)
        case selectTab(Page)
    }
    
    init() {
        print("MainTabFeature init \(UserDefaultsManager.shared.loadUserProfile()?.email ?? "")")
    }
    var body: some ReducerOf<Self> {
        
        Reduce { state, action in
            switch action {
            case .selectTab(let tab):
                state.selectedTab = tab // 선택된 탭 상태 변경
                return .none
                
            case .board(let boardAction):
                if case .mainTabToggle(let isMaintab) = boardAction {
                    print("mainTabTogglemainTabToggle \(isMaintab)")
                    state.isMainTab = isMaintab
                }
                return .none
            case .profile(let profileAction):
                if case .mainTabToggle(let isMaintab) = profileAction {
                    state.isMainTab = isMaintab
                }
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
