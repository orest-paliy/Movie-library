//
//  NavigationView.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 23.10.2024.
//

import SwiftUI

struct NavigationView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @State var selectedItem: String = "account"
    @State var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path, root: {
            ZStack{
                switch selectedItem{
                    case "home":
                        Text("Home")
                    case "search":
                        SearchView(path: $path)
                    case "saved":
                        SavedListView(path: $path)
                    case "account":
                        AccountView()
                    default:
                        Text("Home2")
                }
                
                HStack(spacing: 30){
                    NavigationIconView(selectedItem: $selectedItem, itemType: "home", iconSystemName: "house")
                    NavigationIconView(selectedItem: $selectedItem, itemType: "search", iconSystemName: "magnifyingglass.circle")
                    NavigationIconView(selectedItem: $selectedItem, itemType: "saved", iconSystemName: "bookmark")
                    NavigationIconView(selectedItem: $selectedItem, itemType: "account", iconSystemName: "person")
                }
                .padding(20)
                .background(.adaptiveCardBackground)
                .cornerRadius(30)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .navigationDestination(for: MovieConcise.self, destination: {movie in
                MovieReviewView(movieId: movie.id)
            })
            .navigationDestination(for: String.self, destination: {id in
                MovieReviewView(movieId: id)
            })
        })
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    NavigationView()
}
