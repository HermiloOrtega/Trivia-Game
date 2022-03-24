//
//  Language.swift
//  TriviaGame
//
//  Created by Jose Hermilo Ortega Martinez on 2020-06-04.
//  Copyright © 2020 Jose Hermilo Ortega Martinez. All rights reserved.
//

import Foundation

// MARK: - Language
struct Language: Codable {
    let id: Int?
    let description: String?

    enum CodingKeys: String, CodingKey {
        case    id = "status_code",
                description = "status_message"
    }
}
