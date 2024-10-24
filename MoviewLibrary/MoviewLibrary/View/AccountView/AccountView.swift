//
//  AccountView.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 23.10.2024.
//

import SwiftUI

struct AccountView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("showHistory") private var showHistory = true
    var body: some View {
        
        VStack{
            ZStack(){
                Circle()
                    .frame(maxWidth: 150)
                    .foregroundStyle(.separator)
                
                Image(systemName: "person")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 80)
                    .fontWeight(.ultraLight)
                    .foregroundStyle(.white)
            }
            Text("Your name")
                .font(.title2)
            
            Form{
                Section("Appearence", content: {
                    Toggle("Dark mode", isOn: $isDarkMode)
                    Toggle("Show search history", isOn: $showHistory)
                })
            }
        }
    }
}

#Preview {
    AccountView()
}
