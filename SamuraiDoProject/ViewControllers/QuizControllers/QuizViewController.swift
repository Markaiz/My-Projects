//
//  QuizViewController.swift
//  SamuraiDoProject
//
//  Created by Mark on 11/10/2017.
//  Copyright © 2017 MarkAiz. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {

    var quiz : QuizCategory!
    var question : Question!
    var points = 0;
    
    var gameInt = 30
    var gameTimer = Timer()
   
    var recordData:String!
    
    @IBOutlet weak var timerSheetlbl: UILabel!
    @IBOutlet weak var timeLeftlbl: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerImage: UIImageView!
    @IBOutlet var quizButtons: [UIButton]!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
       //Timer
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(QuizViewController.gameTime), userInfo: nil, repeats: true)
       //Questions maintance
        navigationItem.title = quiz.title
        loadNextQuestion()
        
        //score
        let userDefaults = Foundation.UserDefaults.standard
        let value = userDefaults.string(forKey: "Record")
        recordData = value
    }
    
    func loadNextQuestion(){
     
        let count = quiz.questions.count
       let index = arc4random_uniform(UInt32(count))
        self.question = quiz.questions[Int(index)]
        
         scoreLabel.text = String(points)
        
        
     refreshUI(with: self.question)
        
        
    }
    
    // DISPLAY ANSWERS ON BUTTONS AND questions on LAbel
    func refreshUI(with q : Question){
       
        let quizQuestion = q.displayText
        answerImage.image = #imageLiteral(resourceName: "ImgQuestion")
        questionLabel.text = quizQuestion
       
        for i in 0..<quizButtons.count{
            quizButtons[i].setTitle(q.answers[i], for: .normal)
        }
        
        
        
        
    }
    
    @IBAction func quizButton(_ sender: UIButton) {
        
        let isCorrect = sender.currentTitle == question.correctAnswer
     
        if isCorrect {
            answerImage.image = #imageLiteral(resourceName: "ImgCorrectAnswer")
            points += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                self.loadNextQuestion()
            })
            
        }else
        {
            answerImage.image = #imageLiteral(resourceName: "ImgWrongImage")
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                self.loadNextQuestion()
            })
        }
       
    }
    @objc func gameTime(){
        
        gameInt -= 1
        timeLeftlbl.text = String(gameInt)
        
        if gameInt == 0 {
            gameTimer.invalidate()
            
            if recordData == nil{
               let savedString = scoreLabel.text
                let userDefaults = Foundation.UserDefaults.standard
                userDefaults.set(savedString, forKey: "Record")
            } else {
                let score:Int? = Int(scoreLabel.text!)
                let record:Int? = Int(recordData)
                
                if score! > record!{
                    let savedString = scoreLabel.text
                    let userDefaults = Foundation.UserDefaults.standard
                    userDefaults.set(savedString, forKey: "Record")
                }
            }
            
            Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(QuizViewController.endGame), userInfo: nil, repeats: false)
            
        }
        
    }
    @objc func endGame(){
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "showScore") as! ScoreViewController
            
            vc.pointsData = scoreLabel.text
            
            self.present(vc, animated: false, completion: nil)
        }
}
