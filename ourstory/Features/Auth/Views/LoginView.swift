//
//  LoginView.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/2/24.
//

import SwiftUI
import ComposableArchitecture


struct LoginView: View {
    let store: StoreOf<AuthFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack {
                VStack(alignment:.center,spacing:0) {
                    
                    OUTextView(text: "OUR STORY",
                               size: 50,
                               style: .bold,
                               color: .green)
                    .padding(EdgeInsets(top: 150, leading: 0, bottom: 0, trailing: 0))
                    
                    OUTextView(text: "서로에게 서로가, 우리들의 이야기 ",
                               size: 20,
                               style: .semiBold,
                               color: .green,
                               maxLines: 2,
                               lineSpacing: 10,
                               alignment: .center)
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 200, trailing: 0))
                    
                    GoogleSignInButton()
                        .frame(width: 280, height: 50)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .onTapGesture {
                            viewStore.send(.signGoogleButtonTapped)
                            
                        }
                    
                }
                .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .top)
                .zIndex(0)
                
                if viewStore.isProgress != false {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .green))
                        .frame(maxWidth:.infinity,maxHeight:.infinity)
                        .background(Color.black.opacity(0.5))
                        .scaleEffect(2)
                        .zIndex(2)
                }
                
            }
            .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .top)
            .background(Color.darkTextColor)
            
        }
    }
}

#Preview {
    LoginView(
        store: Store(initialState: AuthFeature.State()) {
            AuthFeature()
        }
    )
}



