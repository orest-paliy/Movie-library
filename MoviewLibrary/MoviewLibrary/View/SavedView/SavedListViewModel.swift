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
        let movieAsEntityArray: [Movie] = CoreDataManager.shared.fetch<Movie>(entityName: EntityType.movie.rawValue)
        var moviesStructArray: [MovieConcise] = []
        movieAsEntityArray.forEach({
            moviesStructArray.append(MovieConcise(title: $0.title!, year: $0.year!, id: $0.id!, type: $0.type!, posterUrl: $0.posterUrl!))
        })
        return moviesStructArray
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
