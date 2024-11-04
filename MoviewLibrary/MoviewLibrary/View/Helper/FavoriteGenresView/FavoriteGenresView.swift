//
//  FavoriteGenresView.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 03.11.2024.
//

import SwiftUI
import WrappingHStack

struct FavoriteGenresView: View {
    @StateObject var viewModel = FavoriteGenresViewModel()
    @Binding var genresWereSelected: Bool
    
    var body: some View {
        Text("Favorite movie genres")
            .font(.title)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        
        Text("Choose at least 3 favorite movie genres")
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        
        ScrollView{
            WrappingHStack(0..<viewModel.allGenres.count, id:\.self) {
                let item = viewModel.allGenres[$0]
                Button(item){
                    withAnimation{
                        if viewModel.selectedGenres.contains(item){
                            viewModel.selectedGenres.remove(item)
                        } else {
                            viewModel.selectedGenres.insert(item)
                        }
                    }
                }
                .padding()
                .background(.adaptiveCardBackground)
                .cornerRadius(20)
                .overlay{
                    if viewModel.selectedGenres.contains(item){
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(style: StrokeStyle(lineWidth: 3, dash: [10, 5]))
                            .foregroundStyle(.blue)
                    }
                }
                .padding(.vertical, 5)
                .foregroundStyle(
                    viewModel.selectedGenres.contains(item) ? .blue : .gray)
                
            }
            .padding()
        }
        .background(.adaptiveBackground)
        
        Button("Continue"){
            if viewModel.selectedGenres.count >= 3{
                viewModel.saveGenres()
                genresWereSelected = true
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical)
        .background(viewModel.selectedGenres.count >= 3 ? .blue : .adaptiveCardBackground)
        .cornerRadius(20)
        .padding(.horizontal)
        .foregroundStyle(.white)
    }
    
    
}

#Preview {
    FavoriteGenresView(genresWereSelected: .constant(false))
}
