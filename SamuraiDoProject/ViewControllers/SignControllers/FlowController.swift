//
//  FlowController.swift
//  SamuraiDoProject
//
//  Created by Mark on 26/10/2017.
//  Copyright © 2017 MarkAiz. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import UserNotifications

class FlowController {
    
    static let shared = FlowController()
    
    weak var window : UIWindow?
    
    private init (){
        
        
    }
    
        
    
    
    func determineRoot() {
        
        let didLogin = Auth.auth().currentUser != nil
        let name = didLogin ? "Main" : "Login"
        let storyboard = UIStoryboard(name: name, bundle: .main)
        let rootVC = storyboard.instantiateInitialViewController()
        
        window?.rootViewController = rootVC
        
    }
    
    
}
