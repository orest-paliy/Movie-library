//
//  AuthView.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 03.11.2024.
//

import SwiftUI

struct AuthView: View {
    @StateObject var viewModel = AuthViewModel()
    @State var isErrorPresented: Bool = false
    
    var body: some View {
        VStack(spacing: 10){
            TextField("email", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .padding()
                .background(.adaptiveCardBackground)
                .cornerRadius(20)
            
            SecureField("password", text: $viewModel.password)
                .padding()
                .background(.adaptiveCardBackground)
                .cornerRadius(20)
            
            Button(viewModel.isSignUp ? "switchToSignIn" : "switchToSignUp"){
                viewModel.isSignUp.toggle()
            }
            
            Button(viewModel.isSignUp ? "signUp" : "signIn"){
                Task{
                    viewModel.isSignUp
                    ? viewModel.signUp()
                    : viewModel.signIn()
                    
                }
                isErrorPresented = viewModel.validationError != nil
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.blue)
            .cornerRadius(20)
            .foregroundStyle(.white)
        }
        .padding()
        .frame(maxHeight: .infinity)
        .background(.adaptiveBackground)
        .alert("authValidationErrorTitle", isPresented: $isErrorPresented, actions: {
            Button("Ok"){
                isErrorPresented = false
            }
        }, message: {
            if let error = viewModel.validationError{
                Text(NSLocalizedString(error.rawValue, comment: ""))
            }
        })
        .alert("authErrorTitle", isPresented: $viewModel.authError, actions: {
            Button("Ok"){
                viewModel.authError = false
            }
        }, message: {
            if viewModel.validationError == .alreadyExists {
                Text(NSLocalizedString("alreadyExists", comment: ""))
            } else {
                Text("noSuchUser")
            }
        })
    }
}

#Preview {
    AuthView()
}
