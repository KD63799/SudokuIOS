//
//  AuthModels.swift
//  SudokuIOS
//
//  Created by Amir on 24/10/2025.
//

import Foundation

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
