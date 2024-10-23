//
//  MovieReviewModel.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 22.10.2024.
//

import Foundation

final class MovieReviewViewModel: ObservableObject{
    @Published var movie: MovieFullInfo?
    
    func fetchMovieInfo(movieId: String) async{
        do{
            movie = try await MovieNetworkService.shared.getMovieById(id: movieId)
        }catch{
            print(error)
        }
    }
    
    func getActors() -> [String]{
        guard let actorsAsString = movie?.actors else {return []}
        return actorsAsString.components(separatedBy: ", ").map{$0}
    }
}
