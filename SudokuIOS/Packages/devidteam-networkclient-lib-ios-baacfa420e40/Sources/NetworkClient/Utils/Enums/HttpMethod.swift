//
//  HttpMethod.swift
//  NetworkClient
//
//  Created by Martin Gabillet on 22/09/2025.
//

import Foundation

/// An enum to describe all the HttpMethods available for use in the ``WebService`` methods.
public enum HttpMethod: String {
    case get, patch, put, post, delete, head, options, trace, connect
}
