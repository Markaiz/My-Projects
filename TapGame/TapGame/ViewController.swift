//
//  ViewController.swift
//  TapGame
//
//  Created by Mark on 20/11/2017.
//  Copyright © 2017 MarkAiz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    

    @IBAction func startGameButton(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.layer.cornerRadius = 5.0
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userDefaults = Foundation.UserDefaults.standard
        let value = userDefaults.string(forKey: "Record")
        scoreLabel.text = value
        
        
        if (value == nil){
            scoreLabel.text = "0"
        } else {
            scoreLabel.text = value
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

