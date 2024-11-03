//
//  FirebaseAuthManager.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 03.11.2024.
//

import Foundation
import FirebaseAuth

final class FirebaseAuthManager{
    public static let shared = FirebaseAuthManager()
    private init(){}
    
    //MARK: Create account
    public func signUp(email: String, password: String) async throws{
        try await Auth.auth().createUser(withEmail: email, password: password)
    }
    
    //MARK: Loggin
    public func signIn(email: String, password: String) async throws{
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
}
