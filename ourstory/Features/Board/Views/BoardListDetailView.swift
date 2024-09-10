//
//  BoardListDetailView.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/10/24.
//

import SwiftUI
import ComposableArchitecture
struct BoardListDetailView: View {
    let store: StoreOf<BoardFeature>
    var body: some View {
     
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                OUTextView(text: "BoardListDetailView",
                           size: 20,
                           style: .medium,
                           color: .green,
                           alignment: .center)
            }
            .frame(maxWidth: .infinity)
//            .navigationBarBackButtonHidden(true)
        }
        
    }
}

#Preview {
    BoardListDetailView(
        store: Store(initialState: BoardFeature.State()) {
            BoardFeature()
        }
    )
}
