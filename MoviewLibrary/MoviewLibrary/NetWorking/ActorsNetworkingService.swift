//
//  ActorsNetworkingService.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 23.10.2024.
//

import Foundation

final class ActorsNetworkingService{
    public static let shared = ActorsNetworkingService()
    private init (){}
    
    private lazy var API_Key: String = {
        return Bundle.main.object(forInfoDictionaryKey: "ACTORS_API_KEY") as! String
    }()
    
    public lazy var endPoint: String = {
        return "https://api.themoviedb.org/3/search/person?api_key=\(API_Key)"
    }()
    
    //MARK: Get actor's picture URL
    func loadActorProfileImage(actorName: String) async throws(NetworkError) -> String{
        let url = URL(string: "\(endPoint)&query=\(actorName)")!
        var result = ""
        do{
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                throw NetworkError.requestFailed
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let results = json["results"] as? [[String: Any]],
                   let firstResult = results.first,
                   let profilePath = firstResult["profile_path"] as? String {
                        result = "https://image.tmdb.org/t/p/w500\(profilePath)"
                }
            } catch {
                throw NetworkError.noData
            }
        }catch{
            throw .unknownError
        }
        print(result)
        return result
    }
}
