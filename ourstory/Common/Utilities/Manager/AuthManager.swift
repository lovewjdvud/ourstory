//
//  AuthManager.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/2/24.
//

import Foundation

class AuthManager {
    static let shared = AuthManager()
    
    private let tokenKey = "authToken"
    
    private init() {}
    
    func setToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
    }
    
    func getToken() -> String? {
        return UserDefaults.standard.string(forKey: tokenKey)
    }
    
    func clearToken() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
}
