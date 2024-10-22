//
//  SearchView.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 22.10.2024.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = SearchViewModel()
    var body: some View {
        VStack{
            TextField("search", text: $viewModel.searchingName)
                .padding()
                .background(.gray.opacity(0.3))
                .cornerRadius(20)
                .padding()
                .keyboardType(.alphabet)
                .onChange(of: viewModel.searchingName, {
                    Task{
                        await viewModel.searchByName()
                    }
                })
            List{
                ForEach(viewModel.listOfMovie, id: \.id, content: {movie in
                    VStack{
                        AsyncImage(url: URL(string: movie.posterUrl), content: {image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: 200)
                        }, placeholder: {
                            ProgressView()
                        })
                        Text(movie.title)
                    }
                })
            }
        }
    }
}

#Preview {
    SearchView()
}
