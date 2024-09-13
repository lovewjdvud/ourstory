//
//  BoardAddView.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/10/24.
//

import SwiftUI
import ComposableArchitecture
struct BoardAddView: View {
    let store: StoreOf<BoardFeature>
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
            .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .top)
            .onAppear{
                viewStore.send(.mainTabToggle(false))
            }
        }
    }
}

#Preview {
    BoardAddView(
        store: Store(initialState: BoardFeature.State()) {
            BoardFeature()
        }
    )
}
