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
            TabView {
                BoardView(store: store.scope(state: \.boardState, action: \.board))
                    .tabItem {
                        Label("Board", systemImage: "list.bullet")
                    }
                
                ProfileView(store: store.scope(state: \.profileState, action: \.profile))
                    .tabItem {
                        Label("Profile", systemImage: "person.circle")
                    }
            }
        }
        
    }
}
