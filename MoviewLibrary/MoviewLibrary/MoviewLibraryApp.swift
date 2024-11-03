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
    var body: some Scene {
        WindowGroup {
            if isAuthenticated{
                NavigationView()
                    .preferredColorScheme(isDarkMode ? .dark : .light)
            }else{
                AuthView()
            }
        }
    }
}
