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

struct MovieConcise: Decodable, Hashable{
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

struct MovieFullInfo: Decodable{
    var title: String
    var year: String
    var rated: String
    var released: String
    var runtime: String
    var genre: String
    var director: String
    var writer: String
    var actors: String
    var plot: String
    var language: String
    var country: String
    var awards: String
    var posterUrl: String
    var ratings: [Rating]
    var metascore: String
    var imdbRating: String
    var imdbVotes: String
    var movieId: String
    var type: String
    var dvd: String?
    var boxOffice: String?
    var production: String?
    var websiteUrl: String?
    var response: String
    
    private enum CodingKeys: String, CodingKey{
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case posterUrl = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating = "imdbRating"
        case imdbVotes = "imdbVotes"
        case movieId = "imdbID"
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case websiteUrl = "Website"
        case response = "Response"
    }
    
    struct Rating: Decodable{
        var source: String
        var value: String
        
        private enum CodingKeys: String, CodingKey{
            case source = "Source"
            case value = "Value"
        }
    }
}



