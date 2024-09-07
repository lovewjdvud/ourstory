//
//  UserModel.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/2/24.
//

import Foundation
struct UserProfileModel: Codable, Equatable {
     let id: Int
     var name: String?
     var email: String
     var nickname: String?
     var phoneNumber: String?
     var profileImageUrls: [UserProfileImageModel]?
}


