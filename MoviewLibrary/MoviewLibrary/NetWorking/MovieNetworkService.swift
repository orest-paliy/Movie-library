//
//  MovieNetworkService.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 22.10.2024.
//

import Foundation

final class MovieNetworkService{
    public static let shared = MovieNetworkService()
    private init(){}
    
    private lazy var API_key: String = {
        return Bundle.main.object(forInfoDictionaryKey: "API_KEY") as! String
    }()
    
    private var endPoint: String{
        return "https://www.omdbapi.com/?apikey=" + API_key
    }
    
    //MARK: Get Movie by name
    func getMovieByName(nameOfMovie: String) async throws -> Array<MovieConcise>{
        var result = MoviesResponse(movies: [])
        
        guard let url = URL(string: "\(endPoint)&s=\(nameOfMovie)") else {
            throw NetworkError.invalidURL
        }
        do{
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                throw NetworkError.requestFailed
            }
            result = try JSONDecoder().decode(MoviesResponse.self, from: data)
        }catch{
            throw NetworkError.unknownError
        }
        
        return result.movies
    }
    
    //MARK: Get movie full info by id
    func getMovieById(id: String) async throws(NetworkError) -> MovieFullInfo{
        var result: MovieFullInfo
        
        guard let url = URL(string: "\(endPoint)&i=\(id)") else{
            throw NetworkError.invalidURL
        }
        
        do{
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                throw NetworkError.requestFailed
            }
            result = try JSONDecoder().decode(MovieFullInfo.self, from: data)
        }catch{
            throw .unknownError
        }
        
        return result
    }
    

}
