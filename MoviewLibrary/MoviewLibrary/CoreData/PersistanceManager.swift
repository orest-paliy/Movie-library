//
//  PersistanceManager.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 25.10.2024.
//

import CoreData

final class PersistanceManager{
    lazy var persistanceContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MovieData")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error{
                assertionFailure(error.localizedDescription)
            }
        })
        return container
    }()
    
    lazy var persistanceContext: NSManagedObjectContext = {
        persistanceContainer.viewContext
    }()
    
    func saveContext(){
        if persistanceContext.hasChanges{
            do{
                try persistanceContext.save()
            }catch {
                let error = error as NSError
                print(error.localizedDescription)
            }
        }
    }
}
