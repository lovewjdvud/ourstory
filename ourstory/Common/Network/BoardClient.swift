//
//  BoardClient.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/2/24.
//

import Foundation
import ComposableArchitecture
import Dependencies

struct BoardClient {
    var boardList: @Sendable (String?) async throws -> BoardListResponseModel?
    var boardDetail: @Sendable (SignInRequestModel) async throws -> SignInResponseModel?
}

extension BoardClient: DependencyKey {
    static let liveValue: Self = {
        let networkManager = NetworkManager(baseURL: Config.baseURL)
        return Self(
            // 게시글 리스트 요청
            boardList:  { request in
                try await networkManager.request("/board/\(request ?? "A")",
                                                 method: .get,
                                                 queryItems: [],
                                                 body: nil,
                                                 requiresAuth: false)
            },
            // 게시글 상세보기
            boardDetail:  { request_model in
                try await networkManager.request("/board/detail",
                                                 method: .get,
                                                 queryItems: [],
                                                 body: nil,
                                                 requiresAuth: false)
            }
        )
    }()
}

extension DependencyValues {
    var boardClient: BoardClient {
        get { self[BoardClient.self] }
        set { self[BoardClient.self] = newValue }
    }
}
