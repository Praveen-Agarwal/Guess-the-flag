//
//  ViewController.swift
//  Project2
//
//  Created by Praveen Agarwal on 15/08/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswerIndex = 0
    var questionsCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        //CA layer lower to UIView layer
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    func askQuestion(reset: Bool = false) {
        
        if reset {
            score = 0
            questionsCount = 0
        }
        
        countries.shuffle()
        correctAnswerIndex = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswerIndex].uppercased() + "   score: \(score)"
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        questionsCount += 1
        
        if sender.tag == correctAnswerIndex {
            score += 1
            continuePlaying()
        } else {
            score -= 1
            let alert = UIAlertController(title: "Wrong", message: "That's the flag of \(countries[sender.tag])\nYour score: \(score)", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Continue", style: .default) { [weak self] _ in
                self?.continuePlaying()
            })
            
            present(alert, animated: true)
        }
    }
    
    func continuePlaying() {
        if questionsCount == 10 {
            
            let alert = UIAlertController(title: nil, message: "You scored: \(score)", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Play again", style: .default))
            
            present(alert, animated: true)
            askQuestion(reset: true)
            
        } else {
            askQuestion()
        }
    }
}

