//
//  AuthView.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 03.11.2024.
//

import SwiftUI

struct AuthView: View {
    @StateObject var viewModel = AuthViewModel()
    
    var body: some View {
        Image(systemName: "popcorn")
            .font(.largeTitle)
            .foregroundStyle(.blue)
        Text("wellcomeTitle")
            .font(.title)
        Text("wellcomeDesc")
        VStack(spacing: 20){
            Label(viewModel.isSignUp ? "signUp" : "signIn",
                  systemImage: "person.circle")
                .frame(maxWidth: .infinity)
                .font(.title2)
            
            TextField("email", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .padding()
                .background(.adaptiveCardBackground)
                .cornerRadius(20)
            
            SecureField("password", text: $viewModel.password)
                .padding()
                .background(.adaptiveCardBackground)
                .cornerRadius(20)
            
            if viewModel.isSignUp{
                SecureField("passwordConfirmation", text: $viewModel.passwordConfirmation)
                    .padding()
                    .background(.adaptiveCardBackground)
                    .cornerRadius(20)
            }
            Button(viewModel.isSignUp ? "signUp" : "signIn"){
                Task{
                    viewModel.isSignUp
                    ? viewModel.signUp()
                    : viewModel.signIn()
                    
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.blue)
            .cornerRadius(20)
            .foregroundStyle(.white)
            
            HStack{
                Text(viewModel.isSignUp ? "switchToSignIn" : "switchToSignUp")
                Button(viewModel.isSignUp ? "signIn" : "signUp"){
                    withAnimation{
                        viewModel.isSignUp.toggle()
                    }
                }
            }
            
        }
        .padding()
        .background(.adaptiveBackground)
        .cornerRadius(20)
        .padding()
        
        .alert("authValidationErrorTitle", isPresented: .constant(viewModel.validationError != nil), actions: {
            Button("Ok"){
                viewModel.validationError = nil
            }
        }, message: {
            if let error = viewModel.validationError{
                Text(NSLocalizedString(error.rawValue, comment: ""))
            }
        })
    }
}

#Preview {
    AuthView()
}
