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
            VStack {
                if viewStore.isLoggedIn {
                    MainTabView(store: store.scope(state: \.mainTab, action: \.mainTab))
                } else {
                    
                    LoginView(store: store.scope(state: \.authTab, action: \.authTab))
                    
//                    LoginView(store: Store(initialState: AuthFeature.State()) {
//                                AuthFeature()
//                              }
//                    )
                    
                    
//                    GoogleSignInButton()
//                        .frame(width: 280, height: 50)
//                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
//                        .onTapGesture {
//                    
//                            viewStore.send(.checkToken)
//                    
//                        }
//                    
//                    
//                    if viewStore.isProgress {
//                        ProgressView()
//                            .progressViewStyle(CircularProgressViewStyle(tint: .green))
//                            .frame(maxWidth:.infinity,maxHeight:.infinity)
//                            .background(Color.black.opacity(0.5))
//                            .scaleEffect(2)
//                            .zIndex(1)
//                    }

                }
            }
            .frame(maxWidth:.infinity,maxHeight: .infinity)
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
