//
//  SignUpViewController.swift
//  SamuraiDoProject
//
//  Created by Mark on 26/09/2017.
//  Copyright © 2017 MarkAiz. All rights reserved.
//

import UIKit
import Firebase
import FacebookLogin
import FacebookCore
import FBSDKCoreKit
import FBSDKLoginKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    

    var scoreData:String!
    
    
    //Firebase registr
    @IBAction func signUpButton(_ sender: Any) {
        
        guard let email = emailTextField.text else
        {return}
        guard let password = pwTextField.text else
        {return}
        guard let name = nameTextField.text ,!name.isEmpty else {return}
        let userScore = "0"
       
        Auth.auth().createUser(withEmail: email, password: password ) {(user, error)
            in
            //failed
            if let error = error{
                print(error)
                return
            }
            //
            guard let uid = user?.uid else {return}
            //success
            let users = DBManager.manager.userRef.child(uid)
            let values = ["name":name,"email":email,"score":userScore]
            
           users.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if err != nil {
                    print(err ?? "")
                    return
                }
                print("Saved user succefully into FBDB")
            })
            let request = user?.createProfileChangeRequest()
            request?.displayName = name
            request?.commitChanges(completion: { (_) in
                
                //chnage to main flow
                FlowController.shared.determineRoot()
                })    }
    }
    

    
    //facebook login
    @IBAction func FBloginBtnAction(_ sender: UIButton) {
        
        FBSDKLoginManager().logIn(withReadPermissions: ["email","public_profile"], from: self) { (result, err) in
            if err != nil {
                print("FB login failed", err as Any)
                return
            }
            
                  self.loginToFirebaseFB()
            
        }
    }
    //func to add facebook account to firebase Authorization and Database
    func loginToFirebaseFB(){
        let accessToken = FBSDKAccessToken.current()
        let fbsdkgraphRequest = FBSDKGraphRequest(graphPath: "/me", parameters: ["fields":"id, name , email, score"])
        guard let accessTokenString = accessToken?.tokenString else {return}
        
        let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
        Auth.auth().signIn(with: credentials, completion: {(user,error) in
            if error != nil{
                print("failed")
                return
            }
            guard let uid = user?.uid else {return}
            let fbUserRef = DBManager.manager.userRef.child(uid)
            let graphRequest = fbsdkgraphRequest?.start(completionHandler: { (connection, result, err) in
                if ((error) != nil) {
                    // Process error
                    print("Error: \(error ?? "" as! Error)")
                } else {
                    print("fetched user: \(String(describing: result))")
                    let values: [String:AnyObject] = result as! [String : AnyObject]
                    // update our databse by using the child database reference above called fbusersReference
                   fbUserRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
                        // if there's an error in saving to our firebase database
                        if err != nil {
                            print(err ?? "")
                            return
                        }
                        // no error, so it means we've saved the user into our firebase database successfully
                        print("Save the user successfully into Firebase database")
                      FlowController.shared.determineRoot()
                    
                   })
                }
            }
   )}
    )}
    override func viewDidLoad() {
        super.viewDidLoad()

     
        
        
        // Do any additional setup after loading the view.
    }
}

