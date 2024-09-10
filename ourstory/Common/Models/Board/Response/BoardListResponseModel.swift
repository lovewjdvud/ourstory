//
//  BoardListResponseModel.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/9/24.
//

import Foundation



struct BoardListResponseModel: Codable, Equatable {
    var result_cd: Int
    var result_msg: String?
    var detail_msg: String?
    var exception: ExceptionModel?
    var data : [BoardListResponseData]?
    
}

struct BoardListResponseData: Codable, Equatable {
    var id: Int
    var title: String?
    var content: String?
    var comment_count: Int?
    var like_count: Int?
    var tagtype: String?
    var user_id: Int?
    var user_nick_name: String?
    var user_image_url: String?

}


//private long id;
//private String title;
//private String content;
//private int comment_count;
//private int like_count;
//private String tagtype;
//private long user_id;
//private String user_nick_name;
//private String user_image_url;
