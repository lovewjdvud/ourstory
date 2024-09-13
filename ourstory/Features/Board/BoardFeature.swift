//
//  BoardFeature.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/2/24.
//

import Foundation
import ComposableArchitecture
import SwiftUI
struct BoardFeature: Reducer {
    
    @ObservableState
    struct State: Equatable {
        var boardList : [BoardListTestModel] = boardListTestModel
        var boardType : [BoardTypeTestModel] = boardTypeTestModel
        var selectedboardTypeSegment : BoardTypeTestModel = boardTypeTestModel[0]
        var isMainTab : Bool = true
    }
    
    @CasePathable
    @dynamicMemberLookup
    enum Action: BindableAction,Equatable {
        case binding(BindingAction<State>)

        case fetchBoard(BoardType)
        case fetchBoardResponse

        case fetchDetailBoard
        case fetchDetailBoardResponse
        
        case mainTabToggle(Bool)
        
        case boardSegmentTab(BoardTypeTestModel)
        case cancelFail(CancelID,String)
    }
    
    @Dependency(\.boardClient) var boardClient
    
    enum CancelID {
        case fetchDetailBoard
        case fetchBoard
    }
    
    // 전체(A), 위로 받고 싶은 일(B), 연애(C), 친구 (D), 학교 (E),  직장(F)
    enum BoardType : String{
        case A
        case B
        case C
        case D
        case E
        case F
    }
    

    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case.binding :
                return .none
                
           
            case .fetchBoard(let type):
                return .run { send in
                    do {
                        
                        let fetchBoardResultModel = try  await boardClient.boardList(type.rawValue)
                        
                    } catch(let error as NetworkError) {
                        await send(.cancelFail(.fetchBoard, " signIn fail \(error.localizedDescription)"))
                    }
                }
                .cancellable(id: CancelID.fetchBoard)
                
            case .fetchBoardResponse:
                return .run { send in
                    
                    
                }
                
            case .fetchDetailBoard:
                return .run { send in
                    
                    
                }
                .cancellable(id: CancelID.fetchDetailBoard)
                
            case .fetchDetailBoardResponse:
                return .run { send in
                    
                    
                }
            
            case .boardSegmentTab(let type) :
                state.selectedboardTypeSegment = type
                return .none
                
            case .cancelFail(let cancelEnum ,let result_msg):
//                print("AuthFeature Action cancelFail msg = \(result_msg), cancel \(cancelEnum)")
//                state.isProgress = false
                return .cancel(id: cancelEnum)
                
            case .mainTabToggle(let isTab):
                state.isMainTab.toggle()
                return .none
            }
        }
    }
}
