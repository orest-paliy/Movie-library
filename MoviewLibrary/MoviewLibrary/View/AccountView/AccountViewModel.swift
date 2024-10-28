//
//  AccountViewModel.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 25.10.2024.
//

import Foundation

final class AccountViewModel{
    func clear(entityName: String){
        CoreDataManager.shared.delete(entityName:entityName)
    }
}
