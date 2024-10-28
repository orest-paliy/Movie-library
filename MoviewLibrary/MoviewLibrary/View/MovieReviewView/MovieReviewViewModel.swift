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
    
    func isMovieSaved() -> Bool{
        guard let movie = movie,
              let _ = CoreDataManager.shared.fetch<Movie>(by: movie.movieId, entityName: "Movie")
        else {return false}
        return true
    }
    
    func SaveToggle(){
        print(isMovieSaved())
        if isMovieSaved(){
            removeMovieFromSaved()
        }else {
            saveMovie()
        }
    }
    
    private func saveMovie(){
        guard let movie = movie else {return}
        let movieConcise = MovieConcise(
            title: movie.title,
            year: movie.year,
            id: movie.movieId,
            type: movie.type,
            posterUrl: movie.posterUrl)
        
        CoreDataManager.shared.saveMovie(movie: movieConcise)
    }
    
    private func removeMovieFromSaved(){
        guard let movie = movie else {return}
        CoreDataManager.shared.delete(by: movie.movieId, entityName: EntityType.movie.rawValue)
    }
}
