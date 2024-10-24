//
//  SearchView.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 22.10.2024.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @Binding var path: NavigationPath
    var body: some View {
        VStack{
            ZStack{
                TextField("Search", text: $viewModel.searchingName)
                    .padding()
                    .background(.gray.opacity(0.3))
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .keyboardType(.alphabet)
                    .onChange(of: viewModel.searchingName, {
                        Task{
                            await viewModel.searchByName()
                        }
                    })
                Button(action: {
                    viewModel.searchingName = ""
                }, label: {
                    Image(systemName:
                            viewModel.searchingName.isEmpty
                          ? "magnifyingglass.circle"
                          : "xmark.circle")
                        .font(.title2)
                        .foregroundStyle(Color("Black"))
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 30)
            }
            .frame(alignment: .top)
            
            List{
                if !viewModel.searchingName.isEmpty{
                    ForEach(viewModel.listOfMovie, id: \.id, content: {movie in
                        VStack{
                            HStack{
                                Image(systemName: "magnifyingglass")
                                Button(action: {
                                    path.append(movie)
                                    SearchingHistoryService.shared.adMovieToSearchHistory(movieId: movie.id)
                                }){
                                    Text(movie.title)
                                        .lineLimit(1)
                                }
                                Text("(\(movie.year))")
                            }
                            .foregroundStyle(SearchingHistoryService.shared.isMovieViewed(movieId: movie.id) ? .purple :
                                Color("OgBlack"))
                        }
                    })
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
            }
            .listStyle(PlainListStyle())
        }
        .background(._1)
    }
}

#Preview {
    SearchView(path: .constant(NavigationPath()))
}
