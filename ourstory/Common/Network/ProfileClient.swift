//
//  ProfileClient.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/2/24.
//

import Foundation
import ComposableArchitecture
import Dependencies

struct ProfileClient {

}

extension ProfileClient: DependencyKey {
    static let liveValue: Self = {
        return Self()
    }()
}

extension DependencyValues {
    var profileClient: ProfileClient {
        get { self[ProfileClient.self] }
        set { self[ProfileClient.self] = newValue }
    }
}
