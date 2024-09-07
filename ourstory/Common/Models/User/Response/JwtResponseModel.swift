//
//  JwtModel.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/4/24.
//

import Foundation
struct JwtResponseModel: Codable, Equatable {
    let result_cd: Int
    var result_msg: String?
    var detail_msg: String?
    var exception: ExceptionModel?
    
    var data : JwtTokenData?
    
    struct JwtTokenData: Codable, Equatable {
        var user_id: Int?
        var name: String?
        var email: String?
        var grantType: String?
        var accessToken: String?
        var refreshToken: String?

    }
}
