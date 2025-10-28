//
//  Sudoku.swift
//  SudokuIOS
//
//  Created by Amir on 28/10/2025.
//

import Foundation
import NetworkClient

extension Endpoint {
    enum SudokuEndpoints {
        static let updatePseudo = Endpoint(
            urlString: Config.baseUrl + "/functions/v1/update-pseudo",
            method: .post
        )

        static let getGridByLevel = Endpoint(
            urlString: Config.baseUrl + "/functions/v1/get-grid-by-level",
            method: .post
        )

        static let checkSolution = Endpoint(
            urlString: Config.baseUrl + "/functions/v1/check-solution",
            method: .post
        )
    }
}
