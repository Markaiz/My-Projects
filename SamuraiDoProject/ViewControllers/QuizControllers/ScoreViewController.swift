//
//  ScoreViewController.swift
//  SamuraiDoProject
//
//  Created by Mark on 16/10/2017.
//  Copyright © 2017 MarkAiz. All rights reserved.
//

import UIKit
import Firebase

class ScoreViewController: UIViewController {

   
    var pointsData:String!
    @IBOutlet weak var testScoreLabel: UILabel!
    @IBOutlet weak var ScoreImageView: UIImageView!
    @IBAction func backActionMenu(_ sender: Any) {
        FlowController.shared.determineRoot()
        
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testScoreLabel.text = pointsData
       
        self.passCheck()
    }
       //if the quiz passed above 8 write score and update to databse
    func passCheck(){
        let points:Int? = Int(pointsData)
        
        
        if points! >= 8{
            ScoreImageView.image = #imageLiteral(resourceName: "ImgPass")
            
            scoreUpdate()
            print("score updated")
            
        } else {
            ScoreImageView.image = #imageLiteral(resourceName: "ImgFail")
        }
}
    //database score update
    func scoreUpdate(){
      
        let ref = DBManager.manager.rootRef
        ref.child("user").child((Auth.auth().currentUser?.uid)!).updateChildValues(["score":pointsData])
    }
}
