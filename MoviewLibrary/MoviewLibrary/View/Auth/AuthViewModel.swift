//
//  AuthViewModel.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 03.11.2024.
//

import SwiftUI

final class AuthViewModel: ObservableObject{
    var email: String = ""
    var password: String = ""
    var passwordConfirmation: String = ""
    
    @Published var isSignUp: Bool = true
    @Published var validationError: AuthError?
    
    @AppStorage("isAuthenticated") private var isAuthenticated = false
    
    var isEmailValid: Bool{
        validationError = nil
        if email.isEmpty{
            validationError = .emptyEmail
        }else if !email.contains("@gmail.com"){
            validationError = .invalidEmail
        }else{
             let emailPrefix = email.replacingOccurrences(of: "@gmail.com", with: "")
             if emailPrefix.count == 0{
                 validationError = .invalidEmail
             }
        }
        return validationError == nil
    }
    
    var isPasswordValid: Bool{
        validationError = nil
        if password.isEmpty{
            validationError = .emptyPassword
        }else if password.count < 8{
            validationError = .tooShortPassword
        }else if isSignUp{
            if password != passwordConfirmation{
                validationError = .passwordsNotMathcing
            }
        }
        return validationError == nil
    }
    
    func signUp(){
        if isEmailValid && isPasswordValid{
            Task{
                do{
                    try await FirebaseAuthManager.shared.signUp(email: email, password: password)
                    await MainActor.run {
                        isSignUp = false
                        password = ""
                    }
                }catch{
                    await MainActor.run{
                        validationError = .alreadyExists
                    }
                }
            }
        }
    }
    
    func signIn(){
        if isEmailValid && isPasswordValid{
            Task{
                do{
                    try await FirebaseAuthManager.shared.signIn(email: email, password: password)
                    await MainActor.run {
                        isAuthenticated = true
                        UserDefaults.standard.set(email, forKey: "userEmail")
                    }
                }catch{
                    await MainActor.run {
                        validationError = .noUserWithSuchCredentionals
                    }
                }
            }
        }
    }
    
}
