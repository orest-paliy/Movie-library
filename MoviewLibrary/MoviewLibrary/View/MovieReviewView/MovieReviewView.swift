//
//  MovieReviewView.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 22.10.2024.
//

import SwiftUI

struct MovieReviewView: View {
    @StateObject private var viewModel = MovieReviewViewModel()
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
                                .background(Color("6"))
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
                                }
                                .foregroundStyle(.white)
                            }.padding(.horizontal)
                        }
                        .ignoresSafeArea()
                        
                    }, placeholder: {
                        ProgressView()
                            .frame(maxHeight: 400)
                    })
                    
                    VStack(alignment: .leading, spacing: 20){
                        HStack(alignment: .center){
                            ForEach(viewModel.getActors().prefix(3), id: \.self, content: {actorName in
                                ActorView(actorName: actorName)
                            })
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        
                        Text(movie.plot)
                            .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, -140)
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }else{
                ProgressView()
            }
        }
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
