//
//  NetworkClient.swift
//  NetworkClient
//
//  Created by Martin Gabillet on 22/09/2025.
//

import Foundation
import OSLog

public class NetworkClient {
    private let logger = Logger(
        subsystem: "networkclient-lib-ios",
        category: "network"
    )
    
    private let baseUrl: URL
    private let session: URLSession
    private let config: NetworkClientConfig
    
    public init(
        baseUrl: String,
        config: NetworkClientConfig = .defaultConfig
    ) throws {
        guard let baseUrl = URL(string: baseUrl) else {
            logger.error("Incorrect base URL: \(baseUrl)")
            throw NCConfigError.unableToInitWebService
        }
        
        self.baseUrl = baseUrl
        self.session = config.createURLSession()
        self.config = config
    }
    
    public func dataTask<T: Decodable>(
        customSession: URLSession? = nil,
        url: URL,
        httpMethod: HttpMethod,
        body: Data? = nil,
        authenticationScheme: String = Const.authenticationSchemeBearer,
        accessToken: String? = nil,
        customDecoder: JSONDecoder? = nil
    ) async -> NetworkClientResponse<T> {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.httpBody = body
        
        if let accessToken = accessToken {
            urlRequest.setValue("\(authenticationScheme + accessToken)", forHTTPHeaderField: Const.authorizationHeader)
        }
        
        return await process(
            urlRequest: urlRequest,
            customSession: customSession,
            customDecoder: customDecoder
        )
    }
    
    private func process<T: Decodable>(
        urlRequest: URLRequest,
        customSession: URLSession?,
        customDecoder: JSONDecoder?
    ) async -> NetworkClientResponse<T> {
#if DEBUG
        printLogs(for: urlRequest)
#endif
        let executingSession = customSession ?? self.session
        
        do {
            let (data, response) = try await executingSession.data(for: urlRequest)
            
            return NetworkClientResponse<T>(data: data, response: response, decoder: customDecoder ?? config.jsonDecoder)
        } catch {
            return .init(error: .requestFailed(error))
        }
    }
    
    private func printLogs(for request: URLRequest) {
        logger.info("Calling \(request) \n with headers: \(String(describing: request.allHTTPHeaderFields))")
        if let body = request.httpBody,
           let bodyStr = String(data: body, encoding: .utf8) {
            logger.info("With body \(bodyStr)")
        }
    }
}
