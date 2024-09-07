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
    
    struct State: Equatable {
       
    }
    
    enum Action: BindableAction,Equatable {
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.boardClient) var boardClient
    
    private enum CancelID { case signUp }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case.binding :
                return .none
           
            }
        }
    }
}
