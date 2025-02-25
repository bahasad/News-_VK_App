//
//  BDStore.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/8/24.
//


import Foundation
import CoreData

class DBStore {
    
    
    static let shared = DBStore()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        
        let container = NSPersistentContainer(name: "db")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

