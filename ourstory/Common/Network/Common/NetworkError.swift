//
//  NetworkError.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/2/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
    case unauthorized
    case encodingFailed(Error)
}
