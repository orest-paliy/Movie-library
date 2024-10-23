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
                        .foregroundStyle(.black)
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
                                }){
                                    Text(movie.title)
                                        .lineLimit(1)
                                }
                                .foregroundStyle(.black)
                                Text("(\(movie.year))")
                            }
                        }
                    })
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}

#Preview {
    SearchView(path: .constant(NavigationPath()))
}
