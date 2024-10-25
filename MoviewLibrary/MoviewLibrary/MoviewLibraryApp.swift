//
//  MoviewLibraryApp.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 22.10.2024.
//

import SwiftUI

@main
struct MoviewLibraryApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    var body: some Scene {
        WindowGroup {
            NavigationView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
