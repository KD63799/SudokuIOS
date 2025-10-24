//
//  NetworkClientResponse.swift
//  NetworkClient
//
//  Created by Martin Gabillet on 22/09/2025.
//

import Foundation

public struct NetworkClientResponse<T: Decodable> {
    public let object: T?
    public let statusCode: Int?
    public let response: HTTPURLResponse?
    public let error: NetworkClientError?
    
    init(
        data: Data,
        response: URLResponse,
        decoder: JSONDecoder
    ) {
        do {
            let object = try decoder.decode(T.self, from: data)
            self.object = object
            self.error = nil
        } catch {
            object = nil
            self.error = .decodingFailed(
                serializedData: String(data: data, encoding: .utf8) ?? "Unable to serialize data",
                error: error
            )
        }
        
        let response = response as? HTTPURLResponse
        self.response = response
        statusCode = response?.statusCode
    }
    
    init(error: NetworkClientError) {
        object = nil
        statusCode = nil
        response = nil
        self.error = error
    }
    
    public init(mockData: T?, statusCode: Int = 200) {
        object = mockData
        self.statusCode = statusCode
        response = nil
        error = nil
    }
}

public extension NetworkClientResponse {
    var isSuccess: Bool {
        if let statusCode = statusCode, case 200...299 = statusCode {
            return true
        }
        return false
    }
}
