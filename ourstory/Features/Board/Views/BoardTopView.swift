//
//  BoardView.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/2/24.
//
import SwiftUI
import ComposableArchitecture


struct BoardTopView: View {
    let store: StoreOf<BoardFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack(spacing:15){
        
                
                OUTextView(text: "OURSTORY",
                           size: 20,
                           style: .medium,
                           color: .green,
                           alignment: .center)
                .fixedSize(horizontal: true, vertical: false)
                .padding(EdgeInsets(top: 10, leading:00 , bottom: 10, trailing:00 ))

                
                Spacer()
                
                Button(action: {
                    
                }) {
                    Image("noti_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 26)
                }
                
                
                Button(action: {
                    
                }) {
                    Image("dm_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 26)
                }
                
                
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(EdgeInsets(top: 0, leading:20 , bottom: 0, trailing:20 ))
            .frame(maxWidth: .infinity,alignment: .leading)
            .background(Color.darkTextColor)
        }
    }
}
#Preview {
    BoardTopView(
        store: Store(initialState: BoardFeature.State()) {
            BoardFeature()
        }
    )
}
