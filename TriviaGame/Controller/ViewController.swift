//
//  ViewController.swift
//  TriviaGame
//
//  Created by Jose Hermilo Ortega Martinez on 2020-05-28.
//  Copyright © 2020 Jose Hermilo Ortega Martinez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - variable
        var numberOfQuestions : Int = 10
        override func viewDidLoad() {
            super.viewDidLoad()
        }
    
    // MARK: - IBActions
        @IBAction func chooseLevel(_ sender: UIButton) {
            if let level = sender.titleLabel?.text{
                switch level {
                    case "Hard":    numberOfQuestions = 30
                    case "Medium":  numberOfQuestions = 20
                    default:        numberOfQuestions = 10
                }
                performSegue(withIdentifier: "QuestionMovieSeque", sender: nil)
            }
        }
    
    // MARK: segue action
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "QuestionMovieSeque" {
                let resultsViewController = segue.destination as! QuestionMovieViewController
                resultsViewController.numberOfQuestion = self.numberOfQuestions
            }
        }
        @IBAction func unwindToStartQuiz(segue: UIStoryboardSegue) { }
}
