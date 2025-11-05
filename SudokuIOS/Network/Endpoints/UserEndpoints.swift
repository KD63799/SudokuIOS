//
//  Auth.swift
//  SudokuIOS
//
//  Created by Amir on 28/10/2025.
//

import Foundation
import NetworkClient

extension Endpoint {
    enum UserEndpoints {
        static let signIn = Endpoint(
            urlString: Config.baseUrl + "/functions/v1/sign-in",
            method: .post
        )

        static let signUp = Endpoint(
            urlString: Config.baseUrl + "/functions/v1/register",
            method: .post
        )
    }
}
