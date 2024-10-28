//
//  HistoryCoreDataManager.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 25.10.2024.
//

import Foundation
import CoreData

final class CoreDataManager{
    public static var shared = CoreDataManager()
    private init(){}
    
    private let persistanceManager = PersistanceManager()
    
    //MARK: CREATE
    func saveHistoryItem(id: String, name: String){
        guard let entity = NSEntityDescription.entity(forEntityName: EntityType.historyItem.rawValue, in: persistanceManager.persistanceContext) else {return}
        let historyItem = HistoryItem(entity: entity, insertInto: persistanceManager.persistanceContext)
        historyItem.name = name
        historyItem.id = id
        persistanceManager.saveContext()
    }
    
    func saveMovie(movie: MovieConcise){
        guard let movieEntityDescription = NSEntityDescription.entity(forEntityName: EntityType.movie.rawValue, in: persistanceManager.persistanceContext) else{ return }
        let movieEntity = Movie(entity: movieEntityDescription, insertInto: persistanceManager.persistanceContext)
        movieEntity.id = movie.id
        movieEntity.title = movie.title
        movieEntity.year = movie.year
        movieEntity.type = movie.type
        movieEntity.posterUrl = movie.posterUrl
        
        persistanceManager.saveContext()
    }
    
    //MARK: GENERIC CRUD
    
    func fetch<T: NSManagedObject>(entityName: String) -> [T]{
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        let requestResult = try? persistanceManager.persistanceContext.fetch(fetchRequest)
        return requestResult ?? []
    }
    
    func fetch<T: NSManagedObject>(by id: String, entityName: String) -> T?{
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        let requestResult = try? persistanceManager.persistanceContext.fetch(fetchRequest)
        return requestResult?.first
    }
    
    func delete(entityName: String){
        let itemsForDeletion = fetch(entityName: entityName)
        itemsForDeletion.forEach({
            persistanceManager.persistanceContext.delete($0)
        })
        persistanceManager.saveContext()
    }
    
    func delete(by id: String, entityName: String){
        guard let itemForDeletion = fetch(by: id, entityName: entityName) else {return}
        persistanceManager.persistanceContext.delete(itemForDeletion)
        persistanceManager.saveContext()
    }
}

enum EntityType: String{
    case movie = "Movie"
    case historyItem = "HistoryItem"
}
