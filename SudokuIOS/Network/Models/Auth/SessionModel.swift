//
//  Untitled.swift
//  SudokuIOS
//
//  Created by Amir on 31/10/2025.
//

import Foundation

struct Session: Codable {
    let accessToken: String
    let refreshToken: String
    let expiresAt: Int
    let expiresIn: Int
    let tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresAt = "expires_at"
        case expiresIn = "expires_in"
        case tokenType = "token_type"
    }
}
