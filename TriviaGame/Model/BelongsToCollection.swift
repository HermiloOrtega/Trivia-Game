//
//  BelongsToCollection.swift
//  TriviaGame
//
//  Created by Agamenon Rocha Dos Santos on 30/05/20.
//  Copyright © 2020 Jose Hermilo Ortega Martinez. All rights reserved.
//

import Foundation

// MARK: - BelongsToCollection
struct BelongsToCollection: Codable {
    let id: Int?
    let name, posterPath, backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case    id, name,
                posterPath = "poster_path",
                backdropPath = "backdrop_path"
    }
}
