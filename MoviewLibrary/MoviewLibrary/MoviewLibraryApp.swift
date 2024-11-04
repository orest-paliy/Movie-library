//
//  MoviewLibraryApp.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 22.10.2024.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct MoviewLibraryApp: App {
    @AppStorage("isAuthenticated") private var isAuthenticated = false
    @AppStorage("isDarkMode") private var isDarkMode = false
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @State private var genresWereSelected: Bool = false
    @State private var doesUserSelectFavGenres: Bool? = nil  // nil означає, що дані ще не отримані
    
    var body: some Scene {
        WindowGroup {
            if isAuthenticated {
                Group {
                    if let doesUserSelectFavGenres = doesUserSelectFavGenres {
                        if doesUserSelectFavGenres {
                            NavigationView()
                                .preferredColorScheme(isDarkMode ? .dark : .light)
                        } else {
                            if genresWereSelected {
                                NavigationView()
                                    .preferredColorScheme(isDarkMode ? .dark : .light)
                            } else {
                                FavoriteGenresView(genresWereSelected: $genresWereSelected)
                            }
                        }
                    } else {
                        ProgressView()
                    }
                }
                .onAppear {
                    FirebaseDatabaseManager.shared.checkIfUserSelectFavGenres { doesUserSelectFavgenre in
                        doesUserSelectFavGenres = doesUserSelectFavgenre
                    }
                }
            } else {
                AuthView()
            }
        }
    }
}
