//
//  ActorViewModel.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 23.10.2024.
//

import Foundation

final class ActorViewModel: ObservableObject{
    @Published var actorUrl: String = ""
    @Published var error: NetworkError?
    
    public func fetchActorImage(actorName: String) async{
        do{
            actorUrl = try await ActorsNetworkingService.shared.loadActorProfileImage(actorName: actorName)
        }catch{
            self.error = error as NetworkError
        }
    }
}
