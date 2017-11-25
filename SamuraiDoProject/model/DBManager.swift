//
//  DBManager.swift
//  SamuraiDoProject
//
//  Created by Mark on 06/11/2017.
//  Copyright © 2017 MarkAiz. All rights reserved.
//

import Foundation
import Firebase

class DBManager {
    
    static let manager = DBManager()
    
    let rootRef : DatabaseReference
    let userRef : DatabaseReference
    let scoreRef : DatabaseReference
    
    var username : String? {
        get {
            return Auth.auth().currentUser?.uid
        }
    }
    
    var uid : String?{
        get { return Auth.auth().currentUser?.uid}
    }
    var score : String?{
        get{
            return Auth.auth().currentUser?.uid}
    }
    
    private init() {
        rootRef = Database.database().reference()
        userRef = rootRef.child("user")
        scoreRef = userRef.child("score")
        
    }
    
   
}
