//
//  AccountViewModel.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 25.10.2024.
//

import Foundation

final class AccountViewModel{
    func clearMovieLibrary(){
        MovieCoreDataManager.shared.deleteAllMovies()
    }
    
    func clearHistory(){
        HistoryCoreDataManager.shared.deleteAllHistory()
    }
}
