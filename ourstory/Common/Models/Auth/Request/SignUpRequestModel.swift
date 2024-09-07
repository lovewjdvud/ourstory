//
//  SignUpModel.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/2/24.
//

import Foundation
struct SignUpRequestModel: Encodable {
    let email: String
    let name: String?
    let password: String?
    let nickname: String?
    let phoneNumber: String?
    let profileImageUrl: String?
    let snsType: String?
}
