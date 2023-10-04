//
//  PersistentContainer.swift
//  sweetWatch
//
//  Created by Jules Duarte on 04/10/2023.
//

import Foundation

import CoreData

class PersistentContainer: NSPersistentContainer {


    func saveContext(backgroundContext: NSManagedObjectContext? = nil) {
        let context = backgroundContext ?? viewContext
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }
}
