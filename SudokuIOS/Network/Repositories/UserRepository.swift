//
//  UserRepository.swift
//  SudokuIOS
//
//  Created by Amir on 28/10/2025.
//

import Foundation
import NetworkClient

class UserRepository {
    static let shared = UserRepository()
    
    private let networkManager = NetworkClientManager.shared
    
    private(set) var user: User?
    
    private init() {}
    
    func signIn(email: String, password: String) async -> NetworkClientResponse<AuthResponse> {
        let endpoint = Endpoint.UserEndpoints.signIn
        let body = SignInBody(email: email, password: password)
        
        guard let encodedBody = try? JSONEncoder().encode(body) else {
            return NetworkClientResponse(mockData: nil, statusCode: 400)
        }
        let response : NetworkClientResponse<AuthResponse> = await networkManager.dataTask(
            url: endpoint.url,
            httpMethod: endpoint.method,
            body: encodedBody)
        user = response.object?.user
        return response
    }
    
    func signUp(email: String, password: String, pseudo: String) async -> NetworkClientResponse<AuthResponse> {
        let endpoint = Endpoint.UserEndpoints.signUp
        let body = SignUpBody(email: email, password: password, pseudo: pseudo)
        
        guard let encodedBody = try? JSONEncoder().encode(body) else {
            return NetworkClientResponse(mockData: nil, statusCode: 400)
        }
        
        return await networkManager.dataTask(
            url: endpoint.url,
            httpMethod: endpoint.method,
            body: encodedBody
        )
    }
}
