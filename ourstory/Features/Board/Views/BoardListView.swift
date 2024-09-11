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

                    ITNavigationViewLink (
                        destination: {
                        BoardListDetailView(store: store)
                            .ouNavigationSubtitle("테스트")
                    },
                        label: {
                            BoardListRawView(store: store)
                                .frame(maxWidth:.infinity,maxHeight: 400)
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets())
                            
                    },
                        title: "게시글"
                    )
                  
                }
            }
            .background(Color.mainBackgroundColor)
            .listStyle(PlainListStyle())
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
                           color: .white,
                           alignment: .center)
            }
            .frame(maxWidth:.infinity,maxHeight: .infinity)
            .background(Color.darkTextColor)
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
