//
//  BoardListTestModel.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/10/24.
//

import Foundation

struct BoardListTestModel: Identifiable, Hashable {
    let id: Int
    let title: String?
    let content: String?
    let comment_count: Int?
    let like_count: Int?
    let tagtype: String?
    let user_id: Int?
    let user_nick_name: String?
    let user_image_url: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: BoardListTestModel, rhs: BoardListTestModel) -> Bool {
        lhs.id == rhs.id
    }
}

var boardListTestModel: [BoardListTestModel] = [
    BoardListTestModel(id: 1,
             title: "SwiftUI 시작하기",
             content: "SwiftUI를 사용하여 iOS 앱을 만드는 방법을 알아봅시다.",
             comment_count: 5,
             like_count: 10,
             tagtype: "iOS",
             user_id: 101,
             user_nick_name: "김철수",
             user_image_url: "https://example.com/user1.jpg"),
    BoardListTestModel(id: 2,
             title: "Combine 프레임워크 소개",
             content: "Combine을 사용하여 비동기 프로그래밍을 쉽게 할 수 있습니다wift 5.5에서 추가된 새로운 기능들을 살펴봅시다wift 5.5에서 추가된 새로운 기능들을 살펴봅시다wift 5.5에서 추가된 새로운 기능들을 살펴봅시다wift 5.5에서 추가된 새로운 기능들을 살펴봅시다wift 5.5에서 추가된 새로운 기능들을 살펴봅시다wift 5.5에서 추가된 새로운 기능들을 살펴봅시다wift 5.5에서 추가된 새로운 기능들을 살펴봅시다wift 5.5에서 추가된 새로운 기능들을 살펴봅시다wift 5.5에서 추가된 새로운 기능들을 살펴봅시다.",
             comment_count: 3,
             like_count: 7,
             tagtype: "iOS",
             user_id: 102,
             user_nick_name: "이영희",
             user_image_url: "https://example.com/user2.jpg"),
    BoardListTestModel(id: 3,
             title: "Swift 5.5 새로운 기능",
             content: "Swift 5.5에서 추가된 새로운 기능들을 살펴봅시다",
             comment_count: 8,
             like_count: 15,
             tagtype: "Swift",
             user_id: 103,
             user_nick_name: "박민수",
             user_image_url: "https://example.com/user3.jpg")
    ]
