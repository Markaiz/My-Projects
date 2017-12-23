//
//  GameViewController.swift
//  TapGame
//
//  Created by Mark on 20/11/2017.
//  Copyright © 2017 MarkAiz. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    
    @IBOutlet weak var timeRemainingSheet: UILabel!
    @IBOutlet weak var scoreSheet: UILabel!
    @IBOutlet weak var timeRemainLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var tapBtnLbl: UIButton!
    
    
    var tapInt = 0
    
    var startInt = 3
    var startTimer = Timer()
    
    var gameInt = 10
    var gameTimer = Timer()
    
    var recordData:String!
    
    @IBAction func tapMEButton(_ sender: Any) {
        
        tapInt += 1
        scoreLbl.text = String(tapInt)
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tapBtnLbl.layer.cornerRadius = 5.0
        scoreSheet.layer.cornerRadius = 5.0
        timeRemainingSheet.layer.cornerRadius = 5.0
        
        
        tapInt = 0
        scoreLbl.text = String(tapInt)
        gameInt = 10
        timeRemainLbl.text = String(gameInt)
        
        startInt = 3
        tapBtnLbl.setTitle(String(startInt), for: .normal)
        tapBtnLbl.isEnabled = false
        startTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.startGameTimer), userInfo: nil, repeats: true)
        
        let userDefaults = Foundation.UserDefaults.standard
        let value = userDefaults.string(forKey: "Record")
        recordData = value
        
        // Do any additional setup after loading the view.
    }

    @objc func startGameTimer(){
        startInt -= 1
        tapBtnLbl.setTitle(String(startInt), for: .normal)
        
        if startInt == 0 {
            startTimer.invalidate()
            tapBtnLbl.setTitle("tap me", for: .normal)
            tapBtnLbl.isEnabled = true
            
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target:self , selector: #selector(GameViewController.game), userInfo: nil, repeats: true)
            }
    }
    
    @objc func game() {
        gameInt -= 1
        timeRemainLbl.text = String(gameInt)
        
        if gameInt == 0 {
            gameTimer.invalidate()
            
            if recordData == nil {
                let savedString = scoreLbl.text
                let userDefaults = Foundation.UserDefaults.standard
                userDefaults.set(savedString, forKey: "Record")
                
            }else{
                let score:Int? = Int(scoreLbl.text!)
                let record:Int? = Int(recordData)
                
                if score! > record!{
                    let savedString = scoreLbl.text
                    let userDefaults = Foundation.UserDefaults.standard
                    userDefaults.set(savedString, forKey: "Record")
                    
                }
                
            }
           
            
            tapBtnLbl.isEnabled = false
            
            Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(GameViewController.end), userInfo: nil, repeats: false)
        }
        
        
    }
    
    @objc func end() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "endGame") as! EndGameViewController
        
        vc.scoreData = scoreLbl.text
        
        self.present(vc, animated: false, completion: nil)
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
