//
//  AuthValidationError.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 03.11.2024.
//

import Foundation

enum AuthError: String{
    case emptyEmail = "emptyEmail"
    case emptyPassword = "emptyPassword"
    case invalidEmail = "invalidEmail"
    case tooShortPassword = "tooShortPassword"
    case alreadyExists = "alreadyExists"
    case passwordsNotMathcing = "passwordsNotMathcing"
    case noUserWithSuchCredentionals = "noSuchUser"
}
