import UIKit

var str = "Hello, playground"
print(str)

// MARK: - Create classes to movies

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

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
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - BelongsToCollection
struct BelongsToCollection: Codable {
    let id: Int?
    let name: String?
    let posterPath, backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1, name: String?

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

struct ProductionCompany: Codable {
    let id: Int?
    let logoPath: String?
    let name, originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let iso639_1, name: String?

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case name
    }
}


// MARK: - Welcome
struct ResponseError: Codable {
    let statusCode: Int
    let statusMessage: String

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}

// MARK: - NEW CODE

extension URL {
  func withQueries(_ queries: [String: String]) -> URL? {
    var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
    components?.queryItems = queries.map { URLQueryItem(name: $0.key, value: $0.value) }
    return components?.url
  }
}




fileprivate func fetchMovieInfo(queries: [String: String], completion: @escaping (Movie) -> Void) {
  // 1. create url
  let number = Int.random(in: 0 ..< 157400)
  let baseURL = URL(string: "https://api.themoviedb.org/3/movie/\(number)")!
  //let baseURL = URL(string: "https://api.themoviedb.org/3/movie/30810")!
  //let baseURL = URL(string: "https://api.themoviedb.org/3/movie/126566")!
  print(baseURL.absoluteURL)
  let url = baseURL.withQueries(queries)!
  
  // 2. create a data task
  let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
    if let err = error {
      print(err.localizedDescription)
      return
    }
   
        let decoder = JSONDecoder()
        if let data = data {
            print("teste1")
            do {
            let movie = try decoder.decode(Movie.self, from: data)
                print("teste2")
                print(movie)
            }catch {
                print("teste3")
                print(error)
            }
        }
        
   
    
    
//    if let data = data, let movie = try? decoder.decode(Movie.self, from: data) {
//      print(data)
//      completion(movie)
//    }else{
//        if let data = data, let response = try? decoder.decode(ResponseError.self, from: data) {
//            print("Response: code \(response.statusCode) messaage\(response.statusMessage)")
//        }
//    }
  }
  //indicator.startAnimating()
  // 3. resume
  task.resume()
  print("Done")
}

func updateUI(with movie: Movie) {
  DispatchQueue.main.async {
    print(movie.originalTitle)
    print(movie.overview)
    }
}

let movieQueries = [
  "api_key": "66b25c9d7c87e9d04b57fc53a585af95"
]

fetchMovieInfo(queries: movieQueries) { (movie) in
    updateUI(with: movie)
}









