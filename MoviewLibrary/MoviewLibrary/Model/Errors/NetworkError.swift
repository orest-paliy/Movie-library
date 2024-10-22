//
//  NetworkError.swift
//  MoviewLibrary
//
//  Created by Orest Palii on 22.10.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case serverError(statusCode: Int)
    case decodingError
    case noData
    case unknownError
}
