//
//  MainTabView.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/2/24.
//

import SwiftUI
import ComposableArchitecture

struct MainTabView: View {
    let store: StoreOf<MainTabFeature>

    var body: some View {
        
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            TabView(selection: viewStore.binding(
                            get: \.selectedTab,
                            send: MainTabFeature.Action.selectTab
                        ))
            {
                
                BoardView(store: store.scope(state: \.boardState, action: \.board))
                    .tag(Page.board)
                    .tabItem {
                        HStack {
                            Image(viewStore.selectedTab == .board ? "main_tab_board" : "main_tab_board_none" )
                                
                        }
                    }
                
                ProfileView(store: store.scope(state: \.profileState, action: \.profile))
                    .tag(Page.profile)
                    .tabItem {
                        HStack {
                            Image(viewStore.selectedTab == .profile ? "main_tab_profile" : "main_tab_profile_none")
                        }
                    }
                
            } // TabView
            .onAppear {
                
                let appearance = UITabBarAppearance()
                appearance.backgroundColor = UIColor.mainBackgroundColor
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        } // WithViewStore
        
    }
}
