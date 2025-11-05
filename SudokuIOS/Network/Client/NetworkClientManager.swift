//
//  ClientProvider.swift
//  SudokuIOS
//
//  Created by Amir on 28/10/2025.
//

import Foundation
import NetworkClient

class NetworkClientManager {
    static let shared = NetworkClientManager()
    
    private(set) var client: NetworkClient
    
    private init() {
        do {
            self.client = try NetworkClient(
                baseUrl: Config.baseUrl,
                config: NetworkClientConfig(
                    defaultRequestTimeout: 30.0,
                    sessionHeaders: [
                        "apikey": Config.apiKey,
                        "Accept": "application/json",
                        "Content-Type": "application/json"
                    ],
                    jsonDecoder: JSONDecoder()
                )
            )
        } catch {
            fatalError("Impossible d'initialiser NetworkClient: \(error)")
        }
    }
    
    func dataTask<T: Decodable>(
        url: URL,
        httpMethod: HttpMethod,
        body: Data? = nil,
        accessToken: String? = nil
    ) async -> NetworkClientResponse<T> {
        return await client.dataTask(
            url: url,
            httpMethod: httpMethod,
            body: body,
            accessToken: accessToken
        )
    }
}
