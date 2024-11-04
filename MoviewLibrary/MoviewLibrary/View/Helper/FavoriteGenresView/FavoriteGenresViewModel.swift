//
//  FavoriteGenresViewModel.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 03.11.2024.
//

import Foundation
import SwiftUI

final class FavoriteGenresViewModel: ObservableObject{
    var allGenres:[String]
    
    @Published var selectedGenres = Set<String>()
    
    init(){
        allGenres = []
        fillGenres()
    }

    private func fillGenres() {
        if let fileURL = Bundle.main.url(forResource: "allGenres", withExtension: "rtf") {
            do {
                let contents = try String(contentsOf: fileURL, encoding: .utf8)
                let genres = contents.components(separatedBy: ", ").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }.filter { !$0.isEmpty }
                allGenres.append(contentsOf: genres)
            } catch {
                print("Error reading file: \(error)")
            }
        }
        allGenres.removeFirst()
        allGenres.removeLast()
    }
    
    public func saveGenres(){
        FirebaseDatabaseManager.shared.saveFavouriteUserGenres(favGenres: selectedGenres)
    }
}
