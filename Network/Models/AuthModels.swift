//
//  AuthModels.swift
//  SudokuIOS
//
//  Created by Amir on 24/10/2025.
//

import Foundation

struct SignInBody: Codable {
    let email: String
    let password: String
}

struct SignUpBody: Codable {
    let email: String
    let password: String
    let pseudo: String
}

struct AuthResponse: Codable {
    let user: User
    let session: Session
}

struct User: Codable {
    let id: String
    let email: String
    let pseudo: String
    let profilePicture: String
    
    enum CodingKeys: String, CodingKey {
        case id, email, pseudo
        case profilePicture = "profile_picture"
    }
}

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
