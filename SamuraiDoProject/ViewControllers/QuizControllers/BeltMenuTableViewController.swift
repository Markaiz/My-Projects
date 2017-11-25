//
//  MenuTableViewController.swift
//  SamuraiDoProject
//
//  Created by Mark on 12/10/2017.
//  Copyright © 2017 MarkAiz. All rights reserved.
//

import UIKit
import Firebase

class BeltMenuTableViewController: UITableViewController {

    @IBAction func logoutButton(_ sender: Any) {
        try? Auth.auth().signOut()
        FlowController.shared.determineRoot()    }
    
    
    var items = [QuizCategory]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "ImgBelt"))
     self.items = QuizCategory.readFile()
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       return self.items.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let item = self.items[indexPath.row]

        cell.textLabel?.text = item.title
        
        return cell
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let indexPath = tableView.indexPathForSelectedRow, let nextVC = segue.destination as? QuizViewController{
            nextVC.quiz = items[indexPath.row]
        }
        
    }
    

}
