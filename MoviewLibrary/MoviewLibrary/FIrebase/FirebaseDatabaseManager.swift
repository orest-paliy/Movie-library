//
//  FirebaseDatabaseManager.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 03.11.2024.
//

import Foundation
import FirebaseDatabase

final class FirebaseDatabaseManager{
    public static let shared = FirebaseDatabaseManager()
    private init(){}
    
    private let userUId: String? = UserDefaults.standard.string(forKey: "userUId")
    
    private var databaseRef: DatabaseReference = Database.database().reference()
    
    public func checkIfUserSelectFavGenres(_ completion: @escaping (Bool) -> Void){
        if let userUId = userUId{
            databaseRef
                .child("Users")
                .child(userUId)
                .observeSingleEvent(of: .value) { snapshot in
                    completion(snapshot.exists())
                }
        }else {
            completion(false)
        }
    }
    public func saveFavouriteUserGenres(favGenres: Set<String>){
        if let userUId = userUId{
            checkIfUserSelectFavGenres{ doesUserSelectFavGenres in
                if !doesUserSelectFavGenres {
                    self.databaseRef
                        .child("Users")
                        .child(userUId)
                        .setValue(favGenres.map{$0})
                }
            }
        }
    }
}
