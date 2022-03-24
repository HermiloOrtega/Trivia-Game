//
//  SpokenLanguage.swift
//  TriviaGame
//
//  Created by Agamenon Rocha Dos Santos on 30/05/20.
//  Copyright © 2020 Jose Hermilo Ortega Martinez. All rights reserved.
//

import Foundation

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let iso639_1, name: String?

    enum CodingKeys: String, CodingKey {
        case    iso639_1 = "iso_639_1",
                name
    }
}
