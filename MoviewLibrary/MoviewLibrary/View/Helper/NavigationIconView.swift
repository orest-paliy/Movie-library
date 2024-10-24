//
//  NavigationIconView.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 23.10.2024.
//

import SwiftUI

struct NavigationIconView: View {
    @Binding var selectedItem: String
    var itemType: String
    var iconSystemName: String
    
    private var isThisItemSelected: Bool{
        selectedItem == itemType
    }
    var body: some View {
        Button(action: {
            selectedItem = itemType
        }){
            Image(systemName: isThisItemSelected ? "\(iconSystemName).fill" : iconSystemName)
                .font(.title)
                .fontWeight(.regular)
        }
        .foregroundStyle(.ogBlack)
    }
}

#Preview {
    NavigationIconView(selectedItem: .constant("search"), itemType: "home", iconSystemName: "house")
}
