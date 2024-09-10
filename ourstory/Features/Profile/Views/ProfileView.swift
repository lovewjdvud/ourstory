//
//  ProfileView.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/2/24.
//
import SwiftUI
import ComposableArchitecture


struct ProfileView: View {
    let store: StoreOf<ProfileFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                
                Text("ProfileView Welcome,")
                
            }
            .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .top)
            .background(Color.darkTextColor)
        }
    }
}
