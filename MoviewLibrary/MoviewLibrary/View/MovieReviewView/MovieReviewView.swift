//
//  MovieReviewView.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 22.10.2024.
//

import SwiftUI

struct MovieReviewView: View {
    @StateObject private var viewModel = MovieReviewViewModel()
    @State var isMovieLiked: Bool = false
    var movieId: String
    var body: some View {
        VStack{
            if let movie = viewModel.movie{
                VStack{
                    AsyncImage(url: URL(string: movie.posterUrl), content: {image in
                        ZStack{
                            image
                                .resizable()
                                .frame(maxHeight: 400)
                                .aspectRatio(contentMode: .fill)
                                .opacity(0.15)
                                .background(.black.gradient)
                            HStack{
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 200)
                                    .cornerRadius(10)
                                    .shadow(radius: 20)
                                    .padding(.top, 50)
                                VStack(alignment:.leading){
                                    Text(movie.title)
                                        .font(.title)
                                    Text(movie.genre)
                                    Text("\(movie.country) \(movie.year)")
                                    Text(movie.runtime)
                                    Button(action: {
                                        viewModel.SaveToggle()
                                        isMovieLiked = viewModel.isMovieLiked()
                                    }, label: {
                                        Image(systemName: isMovieLiked ? "bookmark.fill" : "bookmark")
                                            .foregroundStyle(isMovieLiked ? .blue : .white)
                                            .font(.title2)
                                    })
                                    .onAppear{
                                        isMovieLiked = viewModel.isMovieLiked()
                                    }
                                }
                                .foregroundStyle(.white)
                            }
                            .padding(.horizontal)
                        }
                        .frame(maxHeight: 400)
                        .ignoresSafeArea()
                        
                    }, placeholder: {
                        ProgressView()
                            .frame(maxHeight: 400)
                    })
                    
                    Form{
                        Section("Main actors"){
                            VStack(alignment: .leading, spacing: 20){
                                HStack(alignment: .center){
                                    ForEach(viewModel.getActors().prefix(3), id: \.self, content: {actorName in
                                        ActorView(actorName: actorName)
                                    })
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                            }
                        }
                        Section("Plot"){
                            Text(movie.plot)
                                .padding(.horizontal)
                        }.listRowSeparator(.hidden)
                    }
                    .padding(.top, -100)
                    .frame(maxHeight: .infinity)
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }else{
                ProgressView()
            }
        }
        .background(.adaptiveBackground)
        .onAppear{
            Task{
                await viewModel.fetchMovieInfo(movieId: movieId)
            }
        }
    }
}

#Preview {
    MovieReviewView(movieId: "tt10872600")
}
