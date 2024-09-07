//
//  BoardView.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/2/24.
//
import SwiftUI
import ComposableArchitecture


struct BoardView: View {
    let store: StoreOf<BoardFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
        
                Text("BoardView Welcome,")

            }
        }
    }
}
