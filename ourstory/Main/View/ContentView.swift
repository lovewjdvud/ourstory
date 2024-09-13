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
    @EnvironmentObject var globalState: GlobalState
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
//                MainTabView(store: store.scope(state: \.mainTab, action: \.mainTab))
                
                if viewStore.isLoggedIn {
                    MainTabView(store: store.scope(state: \.mainTab, action: \.mainTab))
//                       
                } else {
                    
                    LoginView(store: store.scope(state: \.authTab, action: \.authTab))
                    
                }
            }
            .frame(maxWidth:.infinity,maxHeight: .infinity)
            .onAppear {
                viewStore.send(.checkLogin)
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
