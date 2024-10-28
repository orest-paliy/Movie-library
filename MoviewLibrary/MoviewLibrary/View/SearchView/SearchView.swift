//
//  SearchView.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 22.10.2024.
//

import SwiftUI

struct SearchView: View {
    @AppStorage("showHistory") private var showHistory = true
    @StateObject private var viewModel = SearchViewModel()
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack{
            ZStack{
                TextField("Search", text: $viewModel.searchingName)
                    .padding()
                    .background(.adaptiveCardBackground)
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
                    .foregroundStyle(.adaptiveGray)
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 30)
            }
            .frame(alignment: .top)
            if viewModel.searchingName.isEmpty{
                if viewModel.historyItems.isEmpty {
                    VStack{
                        Image(systemName: "clock")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .fontWeight(.ultraLight)
                            .frame(width: 100)
                        Text("Your search history \nis empty")
                            .font(.title)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .foregroundStyle(.adaptiveGray)
                    .background(.adaptiveCardBackground)
                    .cornerRadius(20)
                    .padding()
                }
            }
            List{
                if viewModel.searchingName.isEmpty{
                    if showHistory{
                        if !viewModel.historyItems.isEmpty {
                            ForEach(viewModel.historyItems, id: \.id, content: {movie in
                                VStack{
                                    HStack{
                                        Image(systemName: "clock")
                                        Button(action: {
                                            path.append(movie.id ?? "")
                                        }){
                                            Text(movie.name ?? "")
                                                .lineLimit(1)
                                        }
                                    }
                                    .foregroundStyle(.blue)
                                }
                            })
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                        }
                    }
                }else{
                    ForEach(viewModel.listOfMovie, id: \.id, content: {movie in
                        VStack{
                            HStack{
                                Image(systemName: viewModel.isMovieViewed(id: movie.id) && showHistory ? "clock" :"magnifyingglass")
                                Button(action: {
                                    path.append(movie)
                                    if !viewModel.isMovieViewed(id: movie.id){
                                        viewModel.addMovieToHistory(id: movie.id, name: movie.title)
                                    }
                                }){
                                    Text(movie.title)
                                        .lineLimit(1)
                                }
                                Text("(\(movie.year))")
                            }
                            .foregroundStyle(viewModel.isMovieViewed(id: movie.id) && showHistory ? .blue :
                                    .adaptiveBlack)
                        }
                    })
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
            }
            .listStyle(PlainListStyle())
        }
        .onAppear{
            viewModel.loadHistoryList()
        }
        .background(.adaptiveBackground)
    }
}

#Preview {
    SearchView(path: .constant(NavigationPath()))
}
