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

                    OUNavigationViewLink (
                        destination: {
                        
                        BoardListDetailView(store: store)
                            
                    },
                        label: {
                            
                            BoardListRawView(store: store,
                                             list: list)
                            
                    },
                        title: "게시글"
                    )
                    .frame(maxWidth:.infinity,minHeight: 200,maxHeight: 300)
//                    .background(Color.red)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                   
                }
            }
            .background(Color.mainBackgroundColor)
            .listStyle(PlainListStyle())
        }
    }
}
struct BoardListRawView: View {
    let store: StoreOf<BoardFeature>
    let list : BoardListTestModel
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing:0) {
                
                BoardListRawTopView(store: store, list: list)
//                    .frame(maxWidth:.infinity)
               
                VStack {
                    OUTextView(text: list.content ?? "",
                               size: 20,
                               style: .medium,
                               color: .white, 
                               maxLines: 10,
                               alignment: .leading)
                    .padding(10)
                }
                .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .center)
                .background(Color.mainLightColor)
             
                
                
            }
            .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .top)
            .background(Color.mainLightColor)
            
        }
    }
}

struct BoardListRawTopView: View {
    let store: StoreOf<BoardFeature>
    let list : BoardListTestModel
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack {
                
                Image("test_profile_image")
                    .resizable()
                    .scaledToFit()
                    .frame(width:35 ,height: 35)
                
                OUTextView(text: "song_jp",
                           size: 15,
                           style: .medium,
                           color: .white,
                           alignment: .center)
            }
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth:.infinity,alignment: .leading)
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            .background(Color.mainBackgroundColor)
            
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

