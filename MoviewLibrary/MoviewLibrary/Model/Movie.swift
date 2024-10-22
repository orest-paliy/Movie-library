//
//  Movie.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 22.10.2024.
//

import Foundation

struct MoviesResponse: Decodable {
    let movies: [MovieConcise]
    
    enum CodingKeys: String, CodingKey {
        case movies = "Search"
    }
}

struct MovieConcise: Decodable{
    var title: String
    var year: String
    var id: String
    var type: String
    var posterUrl: String
    
    private enum CodingKeys: String, CodingKey{
        case title = "Title"
        case year = "Year"
        case id = "imdbID"
        case type = "Type"
        case posterUrl = "Poster"
    }
}
