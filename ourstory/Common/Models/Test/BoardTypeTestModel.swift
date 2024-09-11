//
//  BoardTypeTestModel.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/11/24.
//

import Foundation

struct BoardTypeTestModel: Identifiable, Hashable {
    let id: Int
    let tag_cd: String?
    let content: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: BoardTypeTestModel, rhs: BoardTypeTestModel) -> Bool {
        lhs.id == rhs.id
    }
}

var boardTypeTestModel: [BoardTypeTestModel] = [
    BoardTypeTestModel(
        id: 1,
        tag_cd: "A",
        content: "전체"
    ),
    BoardTypeTestModel(
        id: 2,
        tag_cd: "B",
        content: "위로 받고 싶은 일"
    ),
    BoardTypeTestModel(
        id: 3,
        tag_cd: "C",
        content: "연애"
    ),
    BoardTypeTestModel(
        id: 4,
        tag_cd: "D",
        content: "친구"
    ),
    BoardTypeTestModel(
        id: 5,
        tag_cd: "E",
        content: "학교"
    ),
    BoardTypeTestModel(
        id: 6,
        tag_cd: "F",
        content: "직장"
    )
]
