//
//  ResultViewController.swift
//  TriviaGame
//
//  Created by Agamenon Rocha Dos Santos on 31/05/20.
//  Copyright © 2020 Jose Hermilo Ortega Martinez. All rights reserved.
//

import UIKit

extension ResultViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wrongAnswers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        let answer = wrongAnswers[indexPath.row]
        cell.textLabel?.text = "\(answer.index)- \(answer.movieTitle)"
        return cell
    }
}

class ResultViewController: UIViewController {
    
    // MARK: - IBOutlets
        @IBOutlet weak var percentageLabel: UILabel!
        @IBOutlet weak var wrongAnswersTableView: UITableView!
    
    // MARK: - variables
        var answers : [Answer] = []
        var wrongAnswers : [Answer] = []
    
    
    // MARK: - functions
        override func viewDidLoad() {
            super.viewDidLoad()
            wrongAnswersTableView.dataSource = self
            calcAmountOfCorrectAnswers()
            //wrongAnswersTableView.reloadData()
        }
        func calcAmountOfCorrectAnswers(){
            if !answers.isEmpty {
                var amountOfCorrectAnswers = 0
                var index = 1
                for var answer in answers{
                    if answer.isCorrect {
                        amountOfCorrectAnswers += 1
                    }else{
                        answer.index = index
                        addWrongAnswer(answer: answer)
                    }
                    index += 1
                }
                if amountOfCorrectAnswers != 0{
                    let percentage = (Double(amountOfCorrectAnswers) / Double(answers.count) * 100)
                    percentageLabel.text = "\(Int(percentage))%"
                }else{
                    percentageLabel.text = "0%"
                }
                
            }
        }
        func addWrongAnswer(answer : Answer) {
            wrongAnswers.append(answer)
        }
}
