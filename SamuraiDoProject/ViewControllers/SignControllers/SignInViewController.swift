//
//  SignInViewController.swift
//  SamuraiDoProject
//
//  Created by Mark on 26/09/2017.
//  Copyright © 2017 MarkAiz. All rights reserved.
//

import UIKit
import FacebookCore
import FBSDKCoreKit
import Firebase


class SignInViewController: UIViewController {

    
    

    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var pWlogin: UITextField!
    @IBAction func loginButton(_ sender: Any) {
        guard let email = EmailTextField.text,!email.isEmpty else {return}
        guard let password = pWlogin.text else {return}
        
        Auth.auth().signIn(withEmail: email,password: password) {(user, error)
            in
            //failed
            if let error = error{
                print(error)
                return
            } else {
                //success
                FlowController.shared.determineRoot()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}
