//
//  HighScoreViewController.swift
//  SamuraiDoProject
//
//  Created by Mark on 05/11/2017.
//  Copyright © 2017 MarkAiz. All rights reserved.
//

import UIKit
import Firebase
class HighScoreViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    
    @IBOutlet weak var tableView: UITableView!
    
   let cellId = "cellId"
    var users = [User]()
    var scoreData:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "ImgBelt"))
     
        fetchUser()
    }

    func fetchUser(){
        DBManager.manager.userRef.queryOrdered(byChild: "name")
        DBManager.manager.userRef.observe(.value, with: { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                if let value = child.value as? NSDictionary{
                    let user = User()
                    let name = value["name"] as? String ?? "Name not found"
                    let score = value["score"] as? String ?? "No score"
                    user.name = name
                    user.score = score
                    
                    self.users.append(user)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        })
       
    }
    deinit {
        DBManager.manager.userRef.removeAllObservers()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.score
        cell.backgroundColor = UIColor.red
        return cell
    }
   
  
}
