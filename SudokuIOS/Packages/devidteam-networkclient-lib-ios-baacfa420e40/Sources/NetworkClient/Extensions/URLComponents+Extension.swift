//
//  URLComponents+Extension.swift
//  NetworkClient
//
//  Created by Martin Gabillet on 07/10/2025.
//

import Foundation

extension URLComponents {
    /// Convenience initializer for creating URLComponents from static string literals
    /// This initializer should only be used with compile-time known valid URL strings
    /// - Parameter staticString: A static string that represents a valid URL
    /// - Note: This initializer will crash the app if the string is not a valid URL,
    ///         so it should only be used with hardcoded, validated URL strings
    init(staticString: String) {
        guard let components = URLComponents(string: staticString) else {
            fatalError("Unable to init URLComponents with: \(staticString)")
        }
        self = components
    }
    
    /// Provides a guaranteed non-nil URL from URLComponents
    /// This computed property should only be used when you are certain that the URLComponents
    /// contains all necessary components to form a valid URL
    /// - Returns: A URL instance
    /// - Note: This property will crash the app if URLComponents cannot generate a valid URL,
    ///         so it should only be used with properly constructed URLComponents
    var guaranteedURL: URL {
        guard let url else {
            fatalError("Unable to generate URL from URLComponents: \(self)")
        }
        return url
    }
}
