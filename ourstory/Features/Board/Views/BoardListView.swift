//
//  BoardListView.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/10/24.
//

import SwiftUI
import ComposableArchitecture
import SwiftUI
import ComposableArchitecture

struct BoardListView: View {
    let store: StoreOf<BoardFeature>
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
    
            List {
                ForEach(viewStore.boardList) { list in

                    ITNavigationViewLink {
                        BoardListDetailView(store: store)
                    } label: {
                        BoardListRawView(store: store)
                            .frame(height: 200)
                           
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(PlainListStyle())
//            .navigationDestination(for: BoardListTestModel.self) { list in
//                BoardListDetailView(store: store)
//            }
        }
    }
}

struct BoardListRawView: View {
    let store: StoreOf<BoardFeature>
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                OUTextView(text: "OURSTORY ㅋㅋ",
                           size: 20,
                           style: .medium,
                           color: .green,
                           alignment: .center)
            }
           
        }
    }
}

#Preview {
    BoardListView(
        store: Store(initialState: BoardFeature.State()) {
            BoardFeature()
        }
    )
}


// 예시
// NavigationStack {
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
