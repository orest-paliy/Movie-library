//
//  NavigationView.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 23.10.2024.
//

import SwiftUI

struct NavigationView: View {
    @State var selectedItem: String = "home"
    @State var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path, root: {
            ZStack{
                switch selectedItem{
                    case "home":
                        Text("Home")
                    case "search":
                        SearchView(path: $path)
                    case "account":
                        Text("Account")
                    default:
                        Text("Home2")
                }
                
                HStack(spacing: 20){
                    NavigationIconView(selectedItem: $selectedItem, itemType: "home", iconSystemName: "house")
                    NavigationIconView(selectedItem: $selectedItem, itemType: "search", iconSystemName: "magnifyingglass.circle")
                    NavigationIconView(selectedItem: $selectedItem, itemType: "account", iconSystemName: "person")
                }
                .padding()
                .background(.white)
                .cornerRadius(20)
                .shadow(radius: 5)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .navigationDestination(for: MovieConcise.self, destination: {movie in
                MovieReviewView(movieId: movie.id)
            })
        })
    }
}

#Preview {
    NavigationView()
}
