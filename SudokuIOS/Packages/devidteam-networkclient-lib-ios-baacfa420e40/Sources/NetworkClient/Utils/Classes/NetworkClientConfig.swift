//
//  NetworkClientConfig.swift
//  NetworkClient
//
//  Created by Martin Gabillet on 23/09/2025.
//

import Foundation

public class NetworkClientConfig {
    public let defaultRequestTimeout: TimeInterval
    public let sessionHeaders: [String: String]
    public let jsonDecoder: JSONDecoder
    
    public init(
        defaultRequestTimeout: TimeInterval,
        sessionHeaders: [String: String],
        jsonDecoder: JSONDecoder,
    ) {
        self.defaultRequestTimeout = defaultRequestTimeout
        self.sessionHeaders = sessionHeaders
        self.jsonDecoder = jsonDecoder
    }
}

extension NetworkClientConfig {
    func createURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = self.defaultRequestTimeout
        configuration.httpAdditionalHeaders = self.sessionHeaders
        return URLSession(configuration: configuration)
    }
}

extension NetworkClientConfig {
    public static var defaultConfig: NetworkClientConfig {
        .init(
            defaultRequestTimeout: 20.0,
            sessionHeaders: [
                Const.acceptHeader: Const.jsonContentType,
                Const.contentTypeHeader: Const.jsonContentType
            ],
            jsonDecoder: JSONDecoder() 
        )
    }
}
