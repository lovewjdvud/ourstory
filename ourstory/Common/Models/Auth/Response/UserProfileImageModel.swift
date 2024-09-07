//
//  UserProfileImageDto.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/4/24.
//

import Foundation
struct UserProfileImageModel: Codable, Equatable ,Identifiable{
    let id: Int
    let urlPath: String
    let createdAt: Date
}
