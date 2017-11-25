//
//  NewsMenuViewController.swift
//  SamuraiDoProject
//
//  Created by Mark on 23/10/2017.
//  Copyright © 2017 MarkAiz. All rights reserved.
//

import UIKit
import Firebase

class NewsMenuViewController: UIViewController {

    
    @IBAction func logoutButton(_ sender: Any) {
        try? Auth.auth().signOut()
        FlowController.shared.determineRoot()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
