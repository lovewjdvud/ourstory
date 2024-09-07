import Foundation
import ComposableArchitecture
import GoogleSignIn

struct TestFeaturse: Reducer {
    struct State: Equatable {
        var isTest: Bool = false

    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case test
    }
    
    
    private enum CancelID { case signUp, googleSignIn }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
                
            case .test:
                state.isTest.toggle()
                return .none
  
            
            default:
                return .none
            }
        }
    }
}
