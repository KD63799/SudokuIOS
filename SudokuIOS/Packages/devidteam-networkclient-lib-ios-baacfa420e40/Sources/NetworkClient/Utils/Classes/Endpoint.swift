//
//  Endpoint.swift
//  NetworkClient
//
//  Created by Martin Gabillet on 07/10/2025.
//

import Foundation

/**
 A configuration object that defines the structure and parameters of a network endpoint.

 The `Endpoint` class encapsulates the essential components needed to construct HTTP requests,
 including the full URL path, HTTP method, and optional query parameters. This class serves as a
 building block for the networking layer, providing a clean and type-safe way to define API endpoints.

 ## Usage

 Endpoints should only be created through extension-based factory methods. The path should include
 the full URL by concatenating your project's base URL configuration with the endpoint path:

 ```swift
 extension Endpoint {
     enum Products {
         static var getAll = Endpoint(
             urlString: Config.baseUrl + "/api/v1/products",
             method: .get,
             queryItems: [URLQueryItem(name: "limit", value: "10")]
         )

         static func getById(_ id: String) -> Endpoint {
             Endpoint(
                 urlString: Config.baseUrl + "/api/v1/products/\(id)",
                 method: .get
             )
         }
     }
 }

 // Usage
 let endpoint = Endpoint.Products.getAll
 ```

 - Important: Always define endpoints through extensions, never instantiate directly in your code.
 */
public class Endpoint {

    /// The complete URL string for the endpoint, including the base URL (e.g., "https://api.example.com/api/v1/products")
    public let urlString: String

    /// The HTTP method to use for requests to this endpoint
    public let method: HttpMethod

    /// Optional query parameters to include in the URL
    public let queryItems: [URLQueryItem]?

    /// The fully constructed URL with urlString and query items combined
    /// - Note: This URL is automatically constructed from the urlString and queryItems during initialization
    public let url: URL

    /**
     Initializes a new endpoint configuration and constructs the complete URL.

     This initializer should only be called from extension-based factory methods, never directly
     in application code. It constructs a complete URL by combining the provided URL string (which includes
     the base URL) with any query parameters.

     - Parameters:
        - urlString: The complete URL string including the base URL (e.g., Config.baseUrl + "/api/v1/products").
                     The base URL should be concatenated from your project's configuration.
        - method: The HTTP method (GET, POST, PUT, DELETE, etc.) for this endpoint
        - queryItems: Optional array of URL query parameters to append to the URL.
                      These will be automatically encoded and added to the constructed URL.

     - Note: The resulting `url` property will contain the complete URL with encoded query parameters.
             This initializer uses `URLComponents` to ensure proper URL encoding.

     - Important: Only call this initializer from within `Endpoint` extensions. Never instantiate
                  endpoints directly in your application code.
     */
    public init(
        urlString: String,
        method: HttpMethod,
        queryItems: [URLQueryItem]? = nil
    ) {
        self.urlString = urlString
        self.method = method
        self.queryItems = queryItems

        var urlComponents = URLComponents(staticString: urlString)
        urlComponents.queryItems = queryItems
        self.url = urlComponents.guaranteedURL
    }
}
