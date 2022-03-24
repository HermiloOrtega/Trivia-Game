//
//  Movie.swift
//  TriviaGame
//
//  Created by Agamenon Rocha Dos Santos on 30/05/20.
//  Copyright © 2020 Jose Hermilo Ortega Martinez. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct Movie: Codable {
    let adult: Bool?
    let backdropPath: String?
    let belongsToCollection: BelongsToCollection?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let imdbID, originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: String?
    let revenue, runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    let status, tagline, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case    adult, backdropPath = "backdrop_path",
                belongsToCollection = "belongs_to_collection",
                budget, genres, homepage, id, imdbID = "imdb_id",
                originalLanguage = "original_language",
                originalTitle = "original_title",
                overview, popularity, posterPath = "poster_path",
                productionCompanies = "production_companies",
                productionCountries = "production_countries",
                releaseDate = "release_date",
                revenue, runtime, spokenLanguages = "spoken_languages",
                status, tagline, title, video, voteAverage = "vote_average",
                voteCount = "vote_count"
    }
}
