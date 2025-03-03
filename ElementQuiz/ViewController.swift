//
//  ViewController.swift
//  ElementQuiz
//
//  Created by SD on 03/03/2025.
//

import UIKit

enum Mode {
    case flashCard
    case quiz
}

enum Stata {
    case questtion
    case answer
}

class ViewController: UIViewController, UITextFieldDelegate {
    let elementList = ["Carbon", "Gold", "Chlorine", "Sodium"]
    var currentElementIndex = 0
    var mode: Mode = .flashCard
    var state: Stata = .questtion
    // Quiz-specific state
    var answerIsCorrect = false
    var correctAnswerCount = 0
    
    @IBOutlet weak var modeSelector: UISegmentedControl!

    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var elementImage: UIImageView!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var showAnswerButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateElement()
    }
    
    @IBAction func next(_ sender: Any) {
        currentElementIndex += 1
        updateElement()
        if currentElementIndex == elementList.count {
            currentElementIndex = 0
        }
        
        state = .questtion
        updateFlashCardUI()
        
    }
    
    @IBAction func showAnswer(_ sender: Any) {
        answerLabel.text = elementList[currentElementIndex]
        state = .answer
        
        updateFlashCardUI()
    }
    
    func updateElement() {
        let elementName =
           elementList[currentElementIndex]
        
        let image = UIImage(named: elementName)
        elementImage.image = image
        answerLabel.text = "?"
    }
    
    
    //Updates the app's UI in flash card mode.
    func updateFlashCardUI() {
        let elementName = elementList[currentElementIndex]
        
        let image = UIImage(named: elementName)
        elementImage.image = image

        if state == .answer {
            answerLabel.text = elementName
        } else {
            answerLabel.text = "?"
        }
    }

    //Updates the app's UI in quiz mode.
    func updateQuizUI() {
        switch state {
        case .questtion:
            answerLabel.text = "?"
        case .answer:
            if answerIsCorrect {
                print("Correct!")
            } else {
                print("icorect!")
            }
        }
    }
    
    //Updates the app's UI based on its mode and state.
    func updateUI() {
        switch mode {
        case .flashCard:
            updateFlashCardUI()
        case .quiz:
            updateQuizUI()
        }
    }
    
    // Runs after the user hits the Return key on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Get the text from the field
        let textFieldContents = textField.text!
        
        // Determine whether the user ansered correctly and update appropriate quiz
        // state
        if textFieldContents.lowercased() == elementList[currentElementIndex].lowercased() {
            answerIsCorrect = true
            correctAnswerCount += 1
        } else {
            answerIsCorrect = false
        }
        
        // The app should now display the answer to the user
        state = .answer
        
        updateUI()
        return true
    }
}

