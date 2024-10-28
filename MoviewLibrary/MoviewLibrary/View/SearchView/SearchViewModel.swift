//
//  SearchViewModel.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 22.10.2024.
//

import Foundation

final class SearchViewModel: ObservableObject{
    @Published var listOfMovie: [MovieConcise] = []
    @Published var historyItems: [HistoryItem] = []
    @Published var searchingName: String = ""
    
    public func searchByName() async{
        do{
            listOfMovie = try await MovieNetworkService.shared.getMovieByName(nameOfMovie: searchingName)
        }catch{
            print(error)
        }
    }
    
    func isMovieViewed(id: String) -> Bool{
        let item: HistoryItem? = CoreDataManager.shared.fetch(by: id, entityName: EntityType.historyItem.rawValue)
        guard let _ = item else {return false}
        return true
    }
    
    func addMovieToHistory(id: String, name: String){
        CoreDataManager.shared.saveHistoryItem(id: id, name: name)
    }
    
    func loadHistoryList(){
        historyItems = CoreDataManager.shared.fetch(entityName: EntityType.historyItem.rawValue)
        historyItems.reverse()
    }
}
