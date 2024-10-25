//
//  SavedListView.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 25.10.2024.
//

import SwiftUI

struct SavedListView: View {
    @StateObject var viewModel = SavedListViewModel()
    @Binding var path: NavigationPath
    
    let columns = [ GridItem(.flexible(minimum: 0, maximum: .infinity), spacing: 20),
                    GridItem(.flexible(minimum: 0, maximum: .infinity), spacing: 20)]
    var body: some View {
        VStack{
            ZStack{
                TextField("Search", text: $viewModel.searchingTitle)
                    .padding()
                    .background(.adaptiveCardBackground)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .keyboardType(.alphabet)
                    .onChange(of: viewModel.searchingTitle, {
                        viewModel.search()
                    })
                Button(action: {
                    viewModel.searchingTitle = ""
                }, label: {
                    Image(systemName:
                            viewModel.searchingTitle.isEmpty
                          ? "magnifyingglass.circle"
                          : "xmark.circle")
                        .font(.title2)
                        .foregroundStyle(.adaptiveGray)
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 30)
            }
            .frame(alignment: .top)
            
            if !viewModel.savedItemList.isEmpty {
            ScrollView(showsIndicators: false){
                LazyVGrid(columns: columns, spacing: 10){
                    ForEach(viewModel.savedItemList, id: \.id, content: {movie in
                        Button(action: {
                            path.append(movie)
                        }, label: {
                            VStack(alignment: .center){
                                AsyncImage(url: URL(string: movie.posterUrl), content: {image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(maxWidth: .infinity)
                                }, placeholder: {
                                    ProgressView()
                                        .frame(width: .infinity, height: 300)
                                })
                                .cornerRadius(20)
                                .padding(.horizontal, 7)
                                .padding(.top, 7)
                                
                                Text(movie.title)
                                    .padding(6)
                            }
                            .foregroundStyle(.adaptiveBlack)
                            .background(.adaptiveCardBackground)
                            .cornerRadius(20)
                        })
                        .shadow(radius: 3)
                    })
                }
                .padding()
            }
            }else{
                VStack{
                    Image(systemName: viewModel.searchingTitle.isEmpty ? "folder" : "xmark.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                        .fontWeight(.ultraLight)
                    Text(viewModel.searchingTitle.isEmpty ? "Your library is empty" : "No Such movie \nin saved")
                        .font(.title)
                        .multilineTextAlignment(.center)
                }
                .padding()
                .foregroundStyle(viewModel.searchingTitle.isEmpty ? .adaptiveGray : .red)
                .frame(width: 300, height: 300)
                .background(.adaptiveCardBackground)
                .cornerRadius(20)
                .padding()
                .padding(.bottom, 80)
                .frame(maxHeight: .infinity)
            }
        }
        .background(.adaptiveBackground)
        .onAppear{
            viewModel.searchingTitle = ""
            viewModel.fetchData()
        }
    }
}

#Preview {
    SavedListView(path: .constant(NavigationPath()))
}
