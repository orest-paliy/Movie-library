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
    
    func isMovieLiked() -> Bool{
        movie?.movieId == MovieCoreDataManager.shared.fetchMovie(by: movie?.movieId ?? "")?.id
    }
    
    func SaveToggle(){
        if isMovieLiked(){
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
        
        MovieCoreDataManager.shared.saveMovie(movie: movieConcise)
    }
    
    private func removeMovieFromSaved(){
        guard let movie = movie else {return}
        MovieCoreDataManager.shared.deleteMovie(by: movie.movieId)
    }
}
