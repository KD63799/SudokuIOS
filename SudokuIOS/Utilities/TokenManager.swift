//
//  Token.swift
//  SudokuIOS
//
//  Created by Amir on 24/10/2025.
//

import Foundation

class TokenManager {
    static let shared = TokenManager()
    
    private let defaults = UserDefaults.standard
    private let accessTokenKey = "accessToken"
    private let refreshTokenKey = "refreshToken"
    
    private init() {}
    
    func saveTokens(accessToken: String, refreshToken: String? = nil) {
        defaults.set(accessToken, forKey: accessTokenKey)
        if let refreshToken {
            defaults.set(refreshToken, forKey: refreshTokenKey)
        }
    }
    
    func getAccessToken() -> String? {
        defaults.string(forKey: accessTokenKey)
    }
    
    func getRefreshToken() -> String? {
        defaults.string(forKey: refreshTokenKey)
    }
    
    func isAuthenticated() -> Bool {
        getAccessToken() != nil
    }
    
    func clearTokens() {
        defaults.removeObject(forKey: accessTokenKey)
        defaults.removeObject(forKey: refreshTokenKey)
    }
}
