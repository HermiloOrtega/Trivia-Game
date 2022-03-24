import UIKit

var str = "Hello, playground"



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




fileprivate func fetchMovieInfo(queries: [String: String], movieId : Int, completion: @escaping (Movie) -> Void) {
  let baseURL = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)")!
  let url = baseURL.withQueries(queries)!
  let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
    if let err = error {
      print(err.localizedDescription)
      return
    }
        let decoder = JSONDecoder()
        if let data = data {
            do {
            let movie = try decoder.decode(Movie.self, from: data)
            //{"adult":false,"id":84333,"original_title":"Save the Date","popularity":6.881,"video":false}
                //print(movie)
                //"\"genres\":[{\"id\":12,\"name\":\"Adventure\"}],
                guard let id = movie.id else { return }
                guard let title = movie.title else { return }
                guard let genres = movie.genres else { return }
                guard let image = movie.backdropPath else { return }
                
                

                print("{\"id\":\(id),\"title\":\"\(title)\"},")
            }catch {
                print("fetchMovieInfo \(error)")
            }
        }
  }
  task.resume()
  //print("Done")
}

let movieQueries = [
  "api_key": "66b25c9d7c87e9d04b57fc53a585af95"
]


// ler arquivo
// loop pela lista
// get nas informacoes
// criar novo arquivo



// 1- load string list
// 2- convert to moviesId array
// 3- get 4 option
// 4- remove the last option from main list
func readBasicMoviesInfo() -> [String]{
    var lines : [String] = []
    if let path = Bundle.main.path(forResource: "movie_ids_05_27_2020", ofType: "json") {
        do {
            let data = try String(contentsOfFile: path, encoding: .utf8)
            lines = data.components(separatedBy: .newlines)
        } catch {
            print("readBasicMoviesInfo \(error)")
        }
    } else {
           print("Invalid filename/path.")
    }
    return lines
}

struct MovieIds: Codable {
    let adult: Bool
    let id: Int
    let originalTitle: String
    let popularity: Double
    let video: Bool

    enum CodingKeys: String, CodingKey {
        case adult, id
        case originalTitle = "original_title"
        case popularity, video
    }
}

func getMovieOptions( fileLines: [String] ) -> [MovieIds] {
    var moviesIds : [MovieIds] = []
    let decoder = JSONDecoder()
    for index in 0 ..< fileLines.count{
        do{
            let movieId = try decoder.decode(MovieIds.self, from:fileLines[index].data(using: .utf8)!)
            moviesIds.append(movieId)
        }catch {
            //print("getMovieOptions\(error)")
        }
    }
    return moviesIds
}

func getGuessMovie(moviesIds : [MovieIds])-> MovieIds{
    let number = Int.random(in: 0 ..< 4)
    return moviesIds[number]
}


print("step1")
var lines = readBasicMoviesInfo()
print("step2")
let moviesIds = getMovieOptions(fileLines: lines)

print(moviesIds.count)

func updateUI(with movie: Movie) {
  DispatchQueue.main.async {
    print("entrou")
    print(movie.originalTitle ?? "")
    print(movie.overview ?? "")
    }
}

for index in 0 ..< moviesIds.count{
    fetchMovieInfo(queries: movieQueries, movieId: moviesIds[index].id) { (movie) in
        updateUI(with: movie)
    }
}










