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
    @State private var selectedSegment: BoardTypeTestModel = boardTypeTestModel[0]

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationView {
                GeometryReader { geometry in
                ZStack {
                    VStack(spacing:0) {
                        
                        BoardTopView(store: store)
                        
                        BoardListView(store: store)
                        
                    }
                    .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .top)
                    .zIndex(0)
//
//                    VStack {
//
//                        OUNavigationViewLink (
//                            destination: {
//                            
//                                BoardAddView(store: store)
//                                
//                        },
//                            label: {
                                Image("write_icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 64,height: 64)
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 40))
                                
                                    .onTapGesture {
                                        viewStore.send(.mainTabToggle(true))
                                    }
//                        },
//                            title: "게시글 작성"
//                        )
//                        .frame(maxWidth:.infinity,maxHeight: .infinity)
                    }
                    .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .bottomTrailing)
                    .zIndex(1)
                    
                }
                .toolbar(viewStore.isMainTab ? .visible : .hidden, for: .tabBar)
                .onAppear{
                    viewStore.send(.mainTabToggle(true))
                }
                .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .top)
            }
                
            }
        }
    
}
#Preview {
    BoardView(
        store: Store(initialState: BoardFeature.State()) {
            BoardFeature()
        }
    )
}

