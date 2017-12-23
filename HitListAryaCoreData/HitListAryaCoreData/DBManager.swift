//
//  DBManager.swift
//  HitListAryaCoreData
//
//  Created by Mark on 04/09/2017.
//  Copyright © 2017 MarkAiz. All rights reserved.
//

import UIKit
import CoreData

class DBManager: NSObject {

    
    static let manager = DBManager()
    
    private override init() {
        super.init()
    }
    
    func victimisFectchedResultController(with query : String?) -> NSFetchedResultsController<Victim>
    {
        let request : NSFetchRequest <Victim> = Victim.fetchRequest()
        
        if let query = query,!query.isEmpty
        {request.predicate = NSPredicate(format:"(firstName CONTAINS[cd] %@) OR (lastName CONTAINS[cd] %@)",query,query)}
        
        let lastnameSort = NSSortDescriptor(key: "lastName", ascending: true)
        let firstnameSort = NSSortDescriptor(key: "firstName", ascending: true)
        
        request.sortDescriptors = [lastnameSort,firstnameSort]
    //create controller
    let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: "lastName", cacheName: nil)
        //fetch data from sqlite
        do {try controller.performFetch()} catch {print(error)}
        return controller
        
        
    
    }
    
    
    
    /*func fetchVictims() -> [Victim]{
        //configure query
        let request : NSFetchRequest <Victim> = Victim.fetchRequest()
        
        let lastnameSort = NSSortDescriptor(key: "lastName", ascending: true)
        let firstnameSort = NSSortDescriptor(key: "firstName", ascending: true)
        
        request.sortDescriptors = [lastnameSort,firstnameSort]
        
        
        //fetch
        
        let result = try? persistentContainer.viewContext.fetch(request)
       return result ?? []
    }*/
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "HitListAryaCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
