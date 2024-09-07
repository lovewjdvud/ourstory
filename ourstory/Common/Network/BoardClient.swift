//
//  BoardClient.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/2/24.
//

import Foundation
import ComposableArchitecture
import Dependencies

struct BoardClient {

}

extension BoardClient: DependencyKey {
    static let liveValue: Self = {
        return Self()
    }()
}

extension DependencyValues {
    var boardClient: BoardClient {
        get { self[BoardClient.self] }
        set { self[BoardClient.self] = newValue }
    }
}
