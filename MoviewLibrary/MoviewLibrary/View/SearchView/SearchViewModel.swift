//
//  SearchViewModel.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 22.10.2024.
//

import Foundation

final class SearchViewModel: ObservableObject{
    @Published var listOfMovie: [MovieConcise] = []
    @Published var searchingName: String = ""
    
    public func searchByName() async{
        do{
            listOfMovie = try await MovieNetworkService.shared.getMovieByName(nameOfMovie: searchingName)
            print(listOfMovie.count)
        }catch{
            print(error)
        }
    }
}
