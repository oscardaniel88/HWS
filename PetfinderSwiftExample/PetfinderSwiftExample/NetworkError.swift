//
//  NetworkError.swift
//  PetfinderSwiftExample
//
//  Created by Daniel Camarena on 2/18/24.
//

import Foundation


enum NetworkError: Error {
    case invalidUrl
    case invalidResponse
    case generalError
}
