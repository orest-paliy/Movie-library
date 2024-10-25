//
//  SavedListViewModel.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 25.10.2024.
//

import Foundation

final class SavedListViewModel: ObservableObject{
    @Published var searchingTitle: String = ""
    @Published var savedItemList: [MovieConcise] = []
    
    public func fetchData(){
        savedItemList = loadArray()
    }
    
    private func loadArray() -> [MovieConcise]{
        CoreDataManager.shared.fetchMovies()
    }
    
    public func search(){
        if searchingTitle.isEmpty{
            fetchData()
        }else{
            savedItemList = loadArray()
                .filter({
                    $0.title.contains(searchingTitle)
                })
        }
    }
}
