//
//  Token.swift
//  SudokuIOS
//
//  Created by Amir on 24/10/2025.
//

import Observation
import NetworkClient

@Observable
class SignInViewModel {
    var email: String = ""
    var password: String = ""
    var errorMessage: String? = nil
    
    private let repository = UserRepository()
    
    func signIn() async -> AppState {
        errorMessage = nil
        
        let response = await repository.signIn(email: email, password: password)
        
        if response.isSuccess, let authData = response.object {
            print("Connecté : \(authData.user.email)")
            print("\(authData.session.accessToken)")
            TokenManager.shared.saveTokens(
                accessToken: authData.session.accessToken,
                refreshToken: authData.session.refreshToken
                
            )
            return .authenticated
        } else {
            errorMessage = "Email ou mot de passe incorrect"
            return .unauthenticated
        }
    }
}
