//
//  BoardTypeSegmentMainView.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/12/24.
//

import SwiftUI
import ComposableArchitecture
struct BoardTypeSegmentMainView: View {
    let store: StoreOf<BoardFeature>
    var body: some View {
        VStack (spacing:0){
            
            OUTextView(text: "고민 카테고리",
                       size: 25,
                       style: .bold,
                       color: .white,
                       alignment: .leading)
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0))
            .frame(maxWidth:.infinity,alignment: .leading)
            
            
            ScrollableSegmentedControl(store: store)
                .frame(maxWidth:.infinity)
                .padding(.top,10)
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
        .background(Color.mainBackgroundColor)
    }
}

struct ScrollableSegmentedControl: View {
   
    let store: StoreOf<BoardFeature>
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(store.boardType) { segment in
                        Button(action: {
                            viewStore.send(.boardSegmentTab(segment))
//                            viewStore.selectedboardTypeSegment = segment
                        }) {
                            OUTextView(text:segment.content ?? "",
                                       size: 17,
                                       style: .medium,
                                       color: viewStore.selectedboardTypeSegment.id  == segment.id ? Color.green : Color.white ,
                                       alignment: .center)
                            .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.gray.opacity(0.2))
                            )
                            .overlay(
                                 RoundedRectangle(cornerRadius: 20)
                                    .stroke(viewStore.selectedboardTypeSegment.id  == segment.id ? Color.green : Color.clear,
                                             lineWidth: 2) // 버튼 둘레를 빨간색으로 칠하는 코드
                             )
                        }
                    }
                }
                .padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10))
            }
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth:.infinity)
            .background(Color.mainBackgroundColor)
        }
    }
}


#Preview {
    BoardTypeSegmentMainView(
        store: Store(initialState: BoardFeature.State()) {
            BoardFeature()
        }
    )
}
