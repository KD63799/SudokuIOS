//
//  ClientProvider.swift
//  SudokuIOS
//
//  Created by Amir on 28/10/2025.
//

import Foundation
import NetworkClient

class NetworkClientManager {
    private(set) var client: NetworkClient
    private let baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
        do {
            self.client = try NetworkClient(
                baseUrl: baseUrl,
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
            fatalError("Impossible d'initialiser NetworkClient")
        }
    }
    
    func dataTask<T: Decodable>(
        customSession: URLSession? = nil,
        url: URL,
        httpMethod: HttpMethod,
        body: Data? = nil,
        authenticationScheme: String = "Bearer ",
        accessToken: String? = nil
    ) async -> NetworkClientResponse<T> {
        return await client.dataTask(
            customSession: customSession,
            url: url,
            httpMethod: httpMethod,
            body: body,
            authenticationScheme: authenticationScheme,
            accessToken: accessToken
        )
    }
}
