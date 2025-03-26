//
//  ViewController.swift
//  Trivia
//
//  Created by Pax Montoro on 3/12/25.
//

import UIKit

class ViewController: UIViewController {
    
    //Connect UI Elements to ViewController
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answerButton1: UIButton!
    
    @IBOutlet weak var answerButton2: UIButton!
    
    @IBOutlet weak var answerButton3: UIButton!
    
    @IBOutlet weak var answerButton4: UIButton!
    
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet weak var restartButton: UIButton!
    
    //Create list of Questions
    var questions: [Question] = []
    var currentQuestionIndex = 0
    var score = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restartButton.isHidden = true
        fetchTriviaQuestions()
    }
    
    func fetchTriviaQuestions() {
        TriviaQuestionService().fetchQuestions { [weak self] triviaQuestions in
            guard let self = self else { return }
            guard let triviaQuestions = triviaQuestions else {
                print("Failed to fetch trivia questions")
                return
            }
            // Map API questions to your local Question model
            let localQuestions = triviaQuestions.map { $0.toLocalQuestion() }
            DispatchQueue.main.async {
                self.questions = localQuestions
                self.currentQuestionIndex = 0
                self.score = 0
                self.loadQuestion()
            }
        }
    }
    
    //Load the first Question
    func loadQuestion() {
        let currentQuestion = questions[currentQuestionIndex]
        // Decode HTML if needed:
        questionLabel.text = currentQuestion.text.htmlDecoded

        let choices = currentQuestion.choices

        // Check if it's a multiple-choice (4 options) or true/false (2 options)
        if choices.count == 4 {
            answerButton1.setTitle(choices[0], for: .normal)
            answerButton2.setTitle(choices[1], for: .normal)
            answerButton3.setTitle(choices[2], for: .normal)
            answerButton4.setTitle(choices[3], for: .normal)
            // Make sure all buttons are visible
            answerButton1.isHidden = false
            answerButton2.isHidden = false
            answerButton3.isHidden = false
            answerButton4.isHidden = false
        } else if choices.count == 2 {
            answerButton1.setTitle(choices[0], for: .normal)
            answerButton2.setTitle(choices[1], for: .normal)
            // Show only the first two buttons
            answerButton1.isHidden = false
            answerButton2.isHidden = false
            answerButton3.isHidden = true
            answerButton4.isHidden = true
        }

        progressLabel.text = "Question \(currentQuestionIndex + 1) of \(questions.count)"
    }
    
    @IBAction func answerTapped(_ sender: UIButton) {
        // Get only the buttons that are currently visible:
        let visibleButtons = [answerButton1, answerButton2, answerButton3, answerButton4].filter { !$0.isHidden }
        
        // Find the index of the tapped button in the visibleButtons array
        if let selectedIndex = visibleButtons.firstIndex(of: sender) {
            let currentQuestion = questions[currentQuestionIndex]
            if selectedIndex == currentQuestion.correctAnswerIndex {
                score += 1
                print("✅ Correct!")
            } else {
                print("❌ Wrong!")
            }
            
            // Delay then load the next question
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.nextQuestion()
            }
        }
    }
   
    
    @IBAction func restartQuiz(_ sender: UIButton) {
        currentQuestionIndex = 0
            score = 0
            restartButton.isHidden = true
            restartButton.alpha = 0
            
            // Show the buttons again
            answerButton1.isHidden = false
            answerButton2.isHidden = false
            answerButton3.isHidden = false
            answerButton4.isHidden = false
            progressLabel.isHidden = false
            
        fetchTriviaQuestions()
    }
    
    func nextQuestion() {
        currentQuestionIndex += 1

        if currentQuestionIndex < questions.count {
            loadQuestion()
        } else {
            // Show final score
            questionLabel.text = "Quiz Complete! Score: \(score)/\(questions.count)"
            answerButton1.isHidden = true
            answerButton2.isHidden = true
            answerButton3.isHidden = true
            answerButton4.isHidden = true
            progressLabel.isHidden = true
            
            // Show the Restart Button
            restartButton.isHidden = false
            restartButton.isEnabled = true
            UIView.animate(withDuration: 0.3) {
                self.restartButton.alpha = 1
            }
        }
    }
}

//Create Question struct
struct Question {
    let text: String
    let choices: [String]
    let correctAnswerIndex: Int
}

import Foundation

// Models that mirror the API JSON
struct TriviaResponse: Decodable {
    let response_code: Int
    let results: [TriviaQuestion]
}

struct TriviaQuestion: Decodable {
    let type: String
    let difficulty: String
    let category: String
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
}

// Service to fetch trivia questions
class TriviaQuestionService {
    func fetchQuestions(completion: @escaping ([TriviaQuestion]?) -> Void) {
        let urlString = "https://opentdb.com/api.php?amount=10"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching questions: \(error)")
                completion(nil)
                return
            }
            guard let data = data else {
                completion(nil)
                return
            }
            do {
                let decoder = JSONDecoder()
                let triviaResponse = try decoder.decode(TriviaResponse.self, from: data)
                completion(triviaResponse.results)
            } catch {
                print("JSON Decoding error: \(error)")
                completion(nil)
            }
        }.resume()
    }
}

extension TriviaQuestion {
    func toLocalQuestion() -> Question {
        var choices = incorrect_answers
        choices.append(correct_answer)
        choices.shuffle()  // Randomize the order so the correct answer isn't always at the end
        let correctIndex = choices.firstIndex(of: correct_answer) ?? 0
        return Question(text: question, choices: choices, correctAnswerIndex: correctIndex)
    }
}

extension String {
    var htmlDecoded: String {
        guard let data = data(using: .utf8) else { return self }
        do {
            let attributedString = try NSAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )
            return attributedString.string
        } catch {
            return self
        }
    }
}
