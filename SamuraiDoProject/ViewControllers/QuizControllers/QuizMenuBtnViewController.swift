//
//  QuizMenuBtnViewController.swift
//  SamuraiDoProject
//
//  Created by Mark on 05/11/2017.
//  Copyright © 2017 MarkAiz. All rights reserved.
//

import UIKit
import Firebase

class QuizMenuBtnViewController: UIViewController {

    @IBOutlet weak var judoQuizbtn: UIButton!
    
    @IBOutlet weak var hScorebtn: UIButton!
    

    @IBAction func logOutBarBtn(_ sender: Any) {
        try? Auth.auth().signOut()
        FlowController.shared.determineRoot()     }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
