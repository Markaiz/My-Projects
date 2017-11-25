//
//  BeltsExam.swift
//  SamuraiDoProject
//
//  Created by Mark on 16/10/2017.
//  Copyright © 2017 MarkAiz. All rights reserved.
//

import Foundation
import UIKit

class QuizCategory{
    let title : String
    let questions : [Question]
    
    init(_ dict : [String:Any]) {
        self.title = dict["title"] as! String
        
        let arr = dict["questions"] as? [[String:Any]] ?? []
        
        self.questions = arr.flatMap{Question($0)}
    }
    
    class func readFile() -> [QuizCategory]
    {
        guard let path = Bundle.main.path(forResource: "Data", ofType: "plist") else{
            print("no file found")
            return []
        }
        
        guard let rawArr = NSArray(contentsOfFile: path) else{
            print("file is not an array")
            return []
        }
        
        guard let dictArr = rawArr as? [[String:Any]] else {
            print("file is not array of dictionaries")
            return []
        }
        
        return dictArr.flatMap{ QuizCategory($0) }
        
    }
}

class Question{
    let displayText : String?
    let answers : [String]
    let correctAnswer : String
    
    init(_ dict : [String:Any]) {
        self.displayText = dict["name"] as? String
        self.answers = dict["answers"] as! Array
        self.correctAnswer = dict["correct"] as! String
    }
}


