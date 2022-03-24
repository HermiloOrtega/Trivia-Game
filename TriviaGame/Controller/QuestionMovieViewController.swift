//
//  MovieViewController.swift
//  TriviaGame
//
//  Created by Agamenon Rocha Dos Santos on 30/05/20.
//  Copyright © 2020 Jose Hermilo Ortega Martinez. All rights reserved.
//

import UIKit

// MARK: - extentions
extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.key, value: $0.value) }
        return components?.url
    }
}

class QuestionMovieViewController: UIViewController {
    
    // MARK: - IBOutlets
        @IBOutlet weak var genreLabel: UILabel!
        @IBOutlet weak var overviewLabel: UILabel!
        @IBOutlet weak var languageLabel: UILabel!
        @IBOutlet weak var backdropImageView: UIImageView!
        @IBOutlet weak var indicator: UIActivityIndicatorView!
        
        @IBOutlet weak var option1Button: UIButton!
        @IBOutlet weak var option2Button: UIButton!
        @IBOutlet weak var option3Button: UIButton!
        @IBOutlet weak var option4Button: UIButton!
    
    // MARK: - variables
        var fileLines: [String] = []
        var fileLanguajes: [String] = []
        var languajes : [Languajes] = []
        var guessMovie: BasicMovieInfo?
        var numberOfQuestion : Int = 10
        var answers : [Answer] = []

        let movieQueries = [
            "api_key": "66b25c9d7c87e9d04b57fc53a585af95"
        ]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            indicator.hidesWhenStopped = true
            fileLines = readBasicMoviesInfo()
            loadQuestion()
            print("number of question \(numberOfQuestion)")
        }
        
    // MARK: - IBAction
        
        @IBAction func chooseOption(_ sender: UIButton) {
            let movieId = sender.tag
            print("movieId \(movieId) tag \(String(describing: guessMovie?.id)) answers.count \(answers.count)")
            if movieId == guessMovie?.id {
                print("movieId == guessMovie?.id")
                answers[answers.count - 1].isCorrect = true
            }
            
            if answers.count == numberOfQuestion{
                performSegue(withIdentifier: "ResultSeque", sender: nil)
            }else{
                loadQuestion()
            }
        }
        
        func loadQuestion(){
            let options = getMovieOptions()
            print("options size ==== \(options.count)")
            option1Button.setTitle(options[0].title, for: .normal)
            option2Button.setTitle(options[1].title, for: .normal)
            option3Button.setTitle(options[2].title, for: .normal)
            option4Button.setTitle(options[3].title, for: .normal)
            option1Button.tag = options[0].id!
            option2Button.tag = options[1].id!
            option3Button.tag = options[2].id!
            option4Button.tag = options[3].id!
            if let title = guessMovie?.title{
                let answer = Answer(movieTitle: title)
                self.answers.append(answer)
            }
            if let movieId = guessMovie?.id {
                fetchMovieInfo(queries: movieQueries,movieId: movieId) { (movie) in
                    self.updateMoveInfo(with: movie)
                }
            }
        }
        
        fileprivate func fetchMovieInfo(queries: [String: String],movieId : Int, completion: @escaping (Movie) -> Void) {
            let baseURL = URL(string: "https://api.themoviedb.org/3/movie/\(movieId))")!
            
            print(baseURL.absoluteURL)
            let url = baseURL.withQueries(queries)!
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let err = error {
                    print(err.localizedDescription)
                    return
                }
                
                //test
                if let returnData = String(data: data!, encoding: .utf8) {
                    print(returnData)
                }
                //end test
                
                
                let decoder = JSONDecoder()
                if let data = data, let movie = try? decoder.decode(Movie.self, from: data) {
                    completion(movie)
                }else{
                    if let data = data, let response = try? decoder.decode(ResponseError.self, from: data) {
                        print("Response: code \(response.statusCode ?? -1 ) messaage\(response.statusMessage ?? "")")
                    }else{
                        print("decode error")
                    }
                }
            }
            indicator.startAnimating()
            task.resume()
            print("Done")
        }
        
        func updateMoveInfo(with movie: Movie) {
            DispatchQueue.main.async {
                var genreList : [String] = []
                if let genres = movie.genres {
                    for genre in genres{
                        genreList.append(genre.name ?? "")
                    }
                }
                if let image = movie.backdropPath {
                    self.updateImage(with: image)
                }
                self.genreLabel.text = genreList.joined(separator: ",")
                
                if let overview : String = movie.overview, let title = movie.title {
                    self.overviewLabel.text = overview.replacingOccurrences(of: title, with: "****")
                }else{
                    self.overviewLabel.text = ""
                }
                self.languageLabel.text = movie.originalLanguage ?? ""
                
            }
        }

        func readLanguajes() -> [String]{
            var languajes : [String] = []
            if let path = Bundle.main.path(forResource: "fileLanguajes", ofType: "json") {
                do {
                    let line = try String(contentsOfFile: path, encoding: .utf8)
                    languajes = line.components(separatedBy: .newlines)
                } catch {
                    print(error)
                }
            } else {
                print("Invalid filename/path languajes")
            }
            return languajes
        }

        func updateImage(with image: String) {
            let baseURL = URL(string: "https://image.tmdb.org/t/p/w300/\(image)")!
            let task = URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
                guard let data = data, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self.backdropImageView.image = image
                    self.indicator.stopAnimating()
                }
            }
            task.resume()
        }
    
    // MARK: use file
        func readBasicMoviesInfo() -> [String]{
            var lines : [String] = []
            if let path = Bundle.main.path(forResource: "movie_ids_05_27_2020", ofType: "json") {
                do {
                    let data = try String(contentsOfFile: path, encoding: .utf8)
                    lines = data.components(separatedBy: .newlines)
                } catch {
                    print(error)
                }
            } else {
                print("Invalid filename/path.")
            }
            return lines
        }
        
        func getMovieOptions() -> [BasicMovieInfo] {
            var options : [BasicMovieInfo] = []
            let newGuessMovie = Int.random(in: 0 ..< 4)
            let decoder = JSONDecoder()
            var index = 0
            while index < 4 {
                do{
                    let number = Int.random(in: 0 ..< fileLines.count)
                    print("try convert json \(fileLines[number])")
                    let option = try decoder.decode(BasicMovieInfo.self, from:fileLines[number].data(using: .utf8)!)
                    options.append(option)
                    print("set guess movie index \(index) newguess \(newGuessMovie)")
                    // set guessMove and remove it from list
                    if(index == newGuessMovie){
                        print("set guess movie option \(option)")
                        guessMovie = option
                        fileLines.remove(at: number)
                    }
                    index += 1
                }catch {
                    print(error)
                }
                
            }
            return options
        }
    
    // MARK: segue action
        override func prepare(for segue: UIStoryboardSegue, sender:
            Any?) {
            
            if segue.identifier == "ResultSeque" {
                let resultViewController = segue.destination as! ResultViewController
                resultViewController.answers = self.answers
            }
        }
}
