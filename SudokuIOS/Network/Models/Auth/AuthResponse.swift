//
//  AuthResponse.swift
//  SudokuIOS
//
//  Created by Amir on 31/10/2025.
//

struct AuthResponse: Decodable {
    let user: User
    let session: Session
}
