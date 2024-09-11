//
//  BoardListRawView.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/11/24.
//

import SwiftUI
import ComposableArchitecture
//struct BoardListRawView: View {
//    let store: StoreOf<BoardFeature>
//    let list : BoardListTestModel
//    var body: some View {
//        WithViewStore(self.store, observe: { $0 }) { viewStore in
//            VStack(spacing:0) {
//                
//                HStack {
//                    
//                    Image("test_profile_image")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width:35 ,height: 35)
//                    
//                    OUTextView(text: "song_jp",
//                               size: 15,
//                               style: .medium,
//                               color: .white,
//                               alignment: .center)
//                }
//                .fixedSize(horizontal: false, vertical: true)
//                .frame(maxWidth:.infinity,alignment: .leading)
//                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
//                .background(Color.mainBackgroundColor)
//                
//                VStack {
//                    OUTextView(text: list.content ?? "",
//                               size: 20,
//                               style: .medium,
//                               color: .white, maxLines: 10,
//                               alignment: .center)
//                }
//                .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .center)
//                .background(Color.darkTextColor)
//                
//            }
//            .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .top)
//            .background(Color.darkTextColor)
//            
//        }
//    }
//}
////#Preview {
////    BoardListRawView(
////        store: Store(initialState: BoardFeature.State()) {
////            BoardFeature()
////        }, list: BoardListTestModel]
////    )
////}
//
//
//struct BoardListRawTopView: View {
//    let store: StoreOf<BoardFeature>
//    let list : BoardListTestModel
//    var body: some View {
//        WithViewStore(self.store, observe: { $0 }) { viewStore in
//            VStack(spacing:0) {
//                
//                HStack {
//                    
//                    Image("test_profile_image")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width:35 ,height: 35)
//                    
//                    OUTextView(text: "song_jp",
//                               size: 15,
//                               style: .medium,
//                               color: .white,
//                               alignment: .center)
//                }
//                .fixedSize(horizontal: false, vertical: true)
//                .frame(maxWidth:.infinity,alignment: .leading)
//                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
//                .background(Color.mainBackgroundColor)
//                
//                VStack {
//                    OUTextView(text: list.content ?? "",
//                               size: 20,
//                               style: .medium,
//                               color: .white, maxLines: 10,
//                               alignment: .center)
//                }
//                .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .center)
//                .background(Color.darkTextColor)
//                
//            }
//            .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .top)
//            .background(Color.darkTextColor)
//            
//        }
//    }
//}
//
