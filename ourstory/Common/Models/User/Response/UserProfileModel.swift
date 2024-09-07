//
//  UserModel.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/2/24.
//

import Foundation
struct UserProfileModel: Codable, Equatable {
    var result_cd: Int
    var result_msg: String?
    var detail_msg: String?
    var exception: ExceptionModel?
    var data: UserProfileData?
}



struct UserProfileData: Codable, Equatable {
     let id: Int
     var name: String?
     var email: String
     var nickname: String?
     var phoneNumber: String?
     var profileImageUrls: [UserProfileImageModel]?
}


//private long id;
//private String name;
//private String email;
//private String nickname;
//private String phone_number;
//private List<UserProfileImageDto> profile_image_url;
