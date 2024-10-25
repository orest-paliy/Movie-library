//
//  HistoryCoreDataManager.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 25.10.2024.
//

import Foundation
import CoreData

final class HistoryCoreDataManager{
    public static var shared = HistoryCoreDataManager()
    private init(){}
    
    private let persistanceManager = PersistanceManager()
    
    //MARK: CREATE
    func saveHistoryItem(id: String, name: String){
        guard let entity = NSEntityDescription.entity(forEntityName: "HistoryItem", in: persistanceManager.persistanceContext) else {return}
        let historyItem = HistoryItem(entity: entity, insertInto: persistanceManager.persistanceContext)
        historyItem.name = name
        historyItem.id = id
        persistanceManager.saveContext()
    }
    
    //MARK: READ
    func fethHistory() -> [HistoryItem]{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HistoryItem")
        let result = try? persistanceManager.persistanceContext.fetch(request) as? [HistoryItem]
        return result ?? []
    }
    
    func fetchHistoryItem(by id: String) -> HistoryItem? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HistoryItem")
        let result = try? persistanceManager.persistanceContext.fetch(request) as? [HistoryItem] ?? []
        return result?.filter({$0.id == id}).first
    }
    
    //MARK: DELETE
    func deleteAllHistory(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HistoryItem")
        let result = try? persistanceManager.persistanceContext.fetch(request) as? [HistoryItem] ?? []
        if let result = result {
            for item in result {
                persistanceManager.persistanceContext.delete(item)
            }
            persistanceManager.saveContext()
        }
    }
    
}
