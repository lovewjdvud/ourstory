//
//  SignUpResponseModel.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/6/24.
//

import Foundation
struct SignUpResponseModel: Codable, Equatable {
    var result_cd: Int
    var result_msg: String?
    var detail_msg: String?
    var exception: ExceptionModel?
    var data : SignUpResponseData?
    
}

struct SignUpResponseData: Codable, Equatable {
    var user_id: Int?
    var name: String?
    var email: String?


}
