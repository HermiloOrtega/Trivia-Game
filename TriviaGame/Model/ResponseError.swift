//
//  ResponseError.swift
//  TriviaGame
//
//  Created by Agamenon Rocha Dos Santos on 30/05/20.
//  Copyright © 2020 Jose Hermilo Ortega Martinez. All rights reserved.
//

import Foundation

// MARK: - ResponseError
struct ResponseError: Codable {
    let statusCode: Int?
    let statusMessage: String?

    enum CodingKeys: String, CodingKey {
        case    statusCode = "status_code",
                statusMessage = "status_message"
    }
}
