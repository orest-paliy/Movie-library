//
//  CoreDataManager.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 25.10.2024.
//

import Foundation
import CoreData

final class CoreDataManager{
    public static let shared = CoreDataManager()
    private init(){}
    
    lazy var persistanceContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MovieData")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error{
                print(error.localizedDescription)
            }
        })
        return container
    }()
    
    lazy var persistanceContext: NSManagedObjectContext = {
        persistanceContainer.viewContext
    }()
    
    private func saveContext(){
        if persistanceContext.hasChanges{
            do{
                try persistanceContext.save()
            }catch {
                let error = error as NSError
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: CREATE
    func saveMovie(movie: MovieConcise){
        guard let movieEntityDescription = NSEntityDescription.entity(forEntityName: "Movie", in: persistanceContext) else{ return }
        let movieEntity = Movie(entity: movieEntityDescription, insertInto: persistanceContext)
        movieEntity.id = movie.id
        movieEntity.title = movie.title
        movieEntity.year = movie.year
        movieEntity.type = movie.type
        movieEntity.posterUrl = movie.posterUrl
        
        saveContext()
    }
    
    // MARK: READ
    func fetchMovies() -> [MovieConcise]{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        do{
            guard let movies = try persistanceContext.fetch(request) as? [Movie] else {return []}
            var moviesAsStruct: [MovieConcise] = []
            
            for movie in movies {
                moviesAsStruct.append(
                    MovieConcise(title: movie.title!,
                                 year: movie.year!,
                                 id: movie.id!,
                                 type: movie.type!,
                                 posterUrl: movie.posterUrl!)
                )
            }
            
            return moviesAsStruct
        }catch{
            let error = error as NSError
            print(error.localizedDescription)
        }
        
        return []
    }
    
    func fetchMovie(by id: String) -> MovieConcise?{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        let movies = try? persistanceContext.fetch(fetchRequest) as? [Movie] ?? []
        guard let movieById = movies?.first(where: {$0.id == id}) else {return nil}
        let movieAsStruct = MovieConcise(title: movieById.title!,
                                         year: movieById.year!,
                                         id: movieById.id!,
                                         type: movieById.type!,
                                         posterUrl: movieById.posterUrl!)
        return movieAsStruct
    }
    
    // MARK: Delete
    
    func deleteAllMovies(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        let movies = try? persistanceContext.fetch(fetchRequest) as? [Movie] ?? []
        
        for movie in movies ?? [] {
            persistanceContext.delete(movie)
        }
        saveContext()
    }
    
    func deleteMovie(by id: String){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        let movies = try? persistanceContext.fetch(fetchRequest) as? [Movie] ?? []
        if let movieForDelete = movies?.first(where: {$0.id == id}){
            persistanceContext.delete(movieForDelete)
        }
        saveContext()
    }
}
