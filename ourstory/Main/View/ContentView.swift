//
//  ContentView.swift
//  ourstory
//
//  Created by Songjeongpyeong on 8/23/24.
//

import SwiftUI
import ComposableArchitecture


struct ContentView: View {
    let store: StoreOf<AppFeature>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Group {
                if viewStore.authTab.isSignin {
                    MainTabView(store: store.scope(state: \.mainTab, action: \.mainTab))
                } else {
                    
                    LoginView(store: store.scope(state: \.authTab, action: \.authTab))
                    
                }
            }
            .onAppear {
//                viewStore.send(.checkToken)
            }
        }
    }
}

//#Preview {
//    ContentView(store: StoreOf<AppFeature>(
//        initialState: AppFeature.State(),
//        reducer: AppFeature()
//    ))
//}
