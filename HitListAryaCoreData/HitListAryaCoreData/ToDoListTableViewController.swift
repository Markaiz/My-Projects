//
//  ToDoListTableViewController.swift
//  HitListAryaCoreData
//
//  Created by Mark on 04/09/2017.
//  Copyright © 2017 MarkAiz. All rights reserved.
//

import UIKit
import CoreData
class ToDoListTableViewController: UITableViewController {
    
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    
    
   // var tableArray : [Victim] = []
    
    var controller : NSFetchedResultsController<Victim>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         searchBar.delegate = self
        refresh(using: nil)
        
        //tableArray = DBManager.manager.fetchVictims()

        self.controller = DBManager.manager.victimisFectchedResultController(with: nil)
        self.controller.delegate = self
        
        navigationItem.leftBarButtonItem = self.editButtonItem
        
    }

   
    func refresh(using query : String?)
    {
    self.controller = DBManager.manager.victimisFectchedResultController(with: query)
        self.controller.delegate = self
        
        self.tableView.reloadData()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return controller.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return controller.sections![section].numberOfObjects
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VictimCell

        // Configure the cell...
        let obj = controller.object(at: indexPath)
               cell.configure(with: obj)
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return controller.sections![section].name
    }
    
    
    
 
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
       return true
    }



    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //delete victim from core data 
    let obj = controller.object(at: indexPath)
            //remove related file
            obj.removeImageFile()
            
    let context = DBManager.manager.persistentContainer.viewContext
    context.delete(obj)
    
    
    DBManager.manager.saveContext()
        }
    
    }
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let nextVC = segue.destination as? VictimViewController,
        segue.identifier == "edit",
            let indexPath = tableView.indexPathForSelectedRow{
            
            nextVC.object = controller.object(at: indexPath)
            
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}


extension ToDoListTableViewController : NSFetchedResultsControllerDelegate{


    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            let index = IndexSet(integer: sectionIndex)
            tableView.insertSections(index, with: .automatic)
        case .delete:
            let index = IndexSet(integer: sectionIndex)
            tableView.deleteSections(index, with: .automatic)
        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            
         tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .update:
            guard let cell = tableView.cellForRow(at: indexPath!) as? VictimCell,
            let victim = anObject as? Victim
                else {
                return
            }
        cell.configure(with: victim)
            
        case .move:
            guard let cell = tableView.cellForRow(at: indexPath!) as? VictimCell,
                let victim = anObject as? Victim
                else {
                    return}
            cell.configure(with: victim)
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        
        }
    }
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }



}


extension ToDoListTableViewController : UISearchBarDelegate{

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        refresh(using: searchText)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        refresh(using: nil)
        
        searchBar.resignFirstResponder()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}



