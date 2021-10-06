//
//  CoreDataStack.swift
//  Navigation
//
//  Created by Misha on 24.09.2021.
//

import UIKit
import CoreData

/*public class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    //Объявляем, чтобы нельзя было создать ещё одну сущность такого же класса
    //private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Navigation")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //Коннект к БД:
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    func fetchTask() -> [Post] {
        
        let request: NSFetchRequest<Post> = Post.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            fatalError("Something wet wrong")
        }
        
    }
    
    
    
    // MARK: - Core Data Saving support
    
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
    
}*/
    

