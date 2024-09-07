//
//  UserDefaultsManager.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/4/24.
//

import Foundation
class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard
    
    private init() {}
    
    enum Keys: String {
        case userProfile
    }
    
    func saveUserProfile(_ profile: UserProfileData) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(profile) {
            defaults.set(encoded, forKey: Keys.userProfile.rawValue)
        }
    }
    
    func loadUserProfile() -> UserProfileData? {
        if let savedProfile = defaults.object(forKey: Keys.userProfile.rawValue) as? Data {
            let decoder = JSONDecoder()
            if let loadedProfile = try? decoder.decode(UserProfileData.self, from: savedProfile) {
                return loadedProfile
            }
        }
        return nil
    }
    
    func deleteUserProfile() {
        defaults.removeObject(forKey: Keys.userProfile.rawValue)
    }
}
