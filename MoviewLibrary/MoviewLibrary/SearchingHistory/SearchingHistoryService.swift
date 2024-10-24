//
//  SearchingHistoryService.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 24.10.2024.
//

import SwiftUI

final class SearchingHistoryService{
    @AppStorage("showHistory") private var showHistory = true
    public static let shared = SearchingHistoryService()
    private init(){}
    
    func isMovieViewed(movieId: String) -> Bool{
        if showHistory{
            return UserDefaults().bool(forKey: movieId)
        } else{
            return false
        }
    }
    
    func adMovieToSearchHistory(movieId: String){UserDefaults().set(true, forKey: movieId)}
    
}
