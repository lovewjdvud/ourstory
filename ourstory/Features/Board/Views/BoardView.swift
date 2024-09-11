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
            NavigationStack {
//                GeometryReader { geometry in
                VStack(spacing:0) {
                        
                        BoardTopView(store: store)
                        
                        BoardListView(store: store)
                    }
                    .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .top)
              
                }
                
//            }
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

// 예시
//NavigationStack {
//           List(posts) { post in
//               NavigationLink(value: post) {
//                   PostRowView(post: post)
//               }
//           }
//           .navigationTitle("게시글 목록")
//           .navigationDestination(for: Post.self) { post in
//               PostDetailView(post: post)
//           }
//       }
