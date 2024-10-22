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
                                .background(.black)
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 200)
                                .cornerRadius(10)
                                .shadow(radius: 20)
                                .padding(.top, 50)
                        }
                        .ignoresSafeArea()
                        
                    }, placeholder: {
                        ProgressView()
                    })
                    
                    VStack{
                        Text(movie.title)
                            .font(.title2)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .offset(y: -70)
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }else{
                ProgressView()
            }
        }.onAppear{
            Task{
                await viewModel.fetchMovieInfo(movieId: movieId)
            }
        }
    }
}

#Preview {
    MovieReviewView(movieId: "tt10872600")
}
