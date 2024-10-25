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
    
    @State var showLibraryDeletionAlert = false
    
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
            Text("Your name")
                .font(.title2)
            
            Form{
                Section("Appearence", content: {
                    Toggle("Dark mode", isOn: $isDarkMode)
                })
                
                Section("Privacy"){
                    Toggle("Show search history", isOn: $showHistory)
                    HStack{
                        Label("Clear search history", systemImage: "magnifyingglass")
                            .foregroundStyle(.adaptiveBlack)
                        Spacer()
                        Image(systemName: "trash")
                            .foregroundStyle(.red)
                    }
                    .foregroundStyle(.white)
                    
                    
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
                            primaryButton:
                                    .destructive(Text("Delete"), action: {
                                    viewModel.clearMovieLibrary()
                                }),
                            secondaryButton: .cancel())
                    })
                    
                }
            }
        }
    }
}

#Preview {
    AccountView()
}