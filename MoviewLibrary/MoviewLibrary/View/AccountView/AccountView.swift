//
//  AccountView.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 23.10.2024.
//

import SwiftUI

struct AccountView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("showHistory") private var showHistory = true
    @AppStorage("isAuthenticated") private var isAuthenticated = false
    
    @State var showLibraryDeletionAlert = false
    @State var showHistoryDeletionAlert = false
    
    let viewModel = AccountViewModel()
    
    var body: some View {
        
        VStack{
            ZStack(){
                Circle()
                    .frame(maxWidth: 150)
                    .foregroundStyle(.separator)
                
                Image(systemName: "person")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 80)
                    .fontWeight(.ultraLight)
                    .foregroundStyle(.white)
            }
            Text(UserDefaults.standard.string(forKey: "userEmail") ?? "")
                .font(.title2)
            
            Form{
                Section("Appearence", content: {
                    Toggle("Dark mode", isOn: $isDarkMode)
                })
                
                Section("Privacy"){
                    Toggle("Show search history", isOn: $showHistory)
                    Button(action: {
                        showHistoryDeletionAlert = true
                    }){
                        HStack{
                            Label("Clear search history", systemImage: "magnifyingglass")
                                .foregroundStyle(.adaptiveBlack)
                            Spacer()
                            Image(systemName: "trash")
                                .foregroundStyle(.red)
                        }
                        .foregroundStyle(.white)
                    }
                    .alert(isPresented: $showHistoryDeletionAlert, content: {
                        Alert(title: Text("Are you sure you want to clear your search history?"),
                            primaryButton: .destructive(Text("Delete"), action: {
                            viewModel.clear(entityName: EntityType.historyItem.rawValue)
                            }),
                            secondaryButton: .cancel())
                    })
                    
                    
                    Button(action: {
                        showLibraryDeletionAlert = true
                    }) {
                        HStack{
                            Label("Delete all saved movies", systemImage: "bookmark")
                                .foregroundStyle(.adaptiveBlack)
                            Spacer()
                            Image(systemName: "trash")
                                .foregroundStyle(.red)
                        }
                    }
                    .alert(isPresented: $showLibraryDeletionAlert, content: {
                        Alert(
                            title: Text("Are you sure you want to delete all saved movies?"),
                            primaryButton: .destructive(Text("Delete"), action: {
                                viewModel.clear(entityName: EntityType.movie.rawValue)
                            }),
                            secondaryButton: .cancel())
                    })
                    
                    Button(action: {
                        isAuthenticated = false
                        UserDefaults.standard.set(nil, forKey: "userUId")
                    }){
                        Label("Log out", systemImage: "rectangle.portrait.and.arrow.right")
                    }
                    .foregroundStyle(.red)
                    
                }
            }
        }
    }
}

#Preview {
    AccountView()
}
