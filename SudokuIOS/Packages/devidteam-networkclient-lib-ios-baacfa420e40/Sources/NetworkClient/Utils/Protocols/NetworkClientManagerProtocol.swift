//
//  NetworkClientManagerProtocol.swift
//  NetworkClient
//
//  Created by Martin Gabillet on 24/09/2025.
//

import Foundation

public protocol NetworkClientManagerProtocol {
    var client: NetworkClient { get }

    func refreshTokens<T: Decodable>() async -> NetworkClientResponse<T>
    func dataTask<T: Decodable>(
        customSession: URLSession?,
        url: URL,
        httpMethod: HttpMethod,
        body: Data?,
        authenticationScheme: String,
        accessToken: String?,
        refreshTokensAndRetry: Bool,
        customDecoder: JSONDecoder?
    ) async -> NetworkClientResponse<T>
}
