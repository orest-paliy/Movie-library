//
//  ActorView.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 23.10.2024.
//

import SwiftUI

struct ActorView: View {
    @StateObject private var viewModel = ActorViewModel()
    var actorName: String
    var body: some View {
        VStack{
                if viewModel.error == nil {
                    if !viewModel.actorUrl.isEmpty{
                        AsyncImage(url: URL(string: viewModel.actorUrl), content: {image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 140)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }, placeholder: {
                            ProgressView()
                                .frame(width: 100, height: 100)
                        })
                    }else{
                        Image(systemName: "person")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding()
                            .frame(width: 100, height: 140)
                            .foregroundStyle(.adaptiveCardBackground)
                            .background(.adaptiveBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
                Text(actorName)
                    .padding(.horizontal, 5)
                    .frame(width: 100)
                    .lineLimit(1)
        }
        .cornerRadius(20)
        .onAppear{
            Task{
                await viewModel.fetchActorImage(actorName: actorName)
            }
            print($viewModel.actorUrl.wrappedValue)
        }
    }
}

#Preview {
    ActorView(actorName: "Benedict Cumberbatch")
}
