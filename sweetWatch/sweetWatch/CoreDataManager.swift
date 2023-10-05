//
//  CoreDataManager.swift
//  sweetWatch
//
//  Created by Jules Duarte on 04/10/2023.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    func save(entityName : String, params : [String: Any]) {
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
      // 1
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      // 2
      let entity =
        NSEntityDescription.entity(forEntityName: entityName,
                                   in: managedContext)!
      
      let entiTyObject = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      
        for param in params {
            entiTyObject.setValue(param.value, forKey: param.key)
        }
        
      do {
        try managedContext.save()
          
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    
    func save(){
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        appDelegate.saveContext()
    }
    
    func getEntity(entityName: String) -> NSManagedObject{
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
          return NSManagedObject()
        }
        
        // 1
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
          NSEntityDescription.entity(forEntityName: entityName,
                                     in: managedContext)!
        
        let entiTyObject = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        return entiTyObject
    }
    
    func fetchObjects<T: NSManagedObject>(_ entity: T.Type, withArguments arguments: [String: Any]) -> [T]{
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            let error : [T] = []
            return error
          }
           
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: entity))

        if !arguments.isEmpty {
                var predicates = [NSPredicate]()
                
                for (key, value) in arguments {
                    let predicate = NSPredicate(format: "%K == %@", key, value as! CVarArg)
                    predicates.append(predicate)
                }
                
                let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: predicates)
                fetchRequest.predicate = compoundPredicate
            }
            
            do {
                let fetchedObjects = try managedContext.fetch(fetchRequest)
                return fetchedObjects
            } catch {
                print("Failed to fetch objects: \(error.localizedDescription)")
                let error : [T] = []
                return error
            }
    }
    
    func delete(item: NSManagedObject){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            return 
          }
           
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        managedContext.delete(item)
        
        do {
                // Enregistrez les modifications dans la base de données
                try managedContext.save()
            } catch {
                print("Erreur lors de la suppression de l'objet : \(error.localizedDescription)")
            }
    }
}
