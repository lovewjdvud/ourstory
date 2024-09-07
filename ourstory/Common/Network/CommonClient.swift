//
//  CommonClient.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/2/24.
//

import Foundation
import ComposableArchitecture
import Dependencies

struct CommonClient {

}

extension CommonClient: DependencyKey {
    static let liveValue: Self = {
        return Self()
    }()
}

extension DependencyValues {
    var commentClient: CommonClient {
        get { self[CommonClient.self] }
        set { self[CommonClient.self] = newValue }
    }
}
