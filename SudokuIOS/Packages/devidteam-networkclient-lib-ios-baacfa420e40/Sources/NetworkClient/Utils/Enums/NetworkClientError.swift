//
//  NetworkClientError.swift
//  NetworkClient
//
//  Created by Martin Gabillet on 22/09/2025.
//

import Foundation

public enum NetworkClientError {
    case decodingFailed(serializedData: String, error: Error),
         requestFailed(Error)
}
