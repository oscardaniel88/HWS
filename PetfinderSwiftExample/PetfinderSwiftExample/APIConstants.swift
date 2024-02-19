//
//  APIConstants.swift
//  PetfinderSwiftExample
//
//  Created by Daniel Camarena on 2/18/24.
//

import Foundation

class APIConstants {
    static let clientId = "pncOEGgcIemvgxbWnK7OwKVkqR4ny1SYrt4cX9ZMTIY3Bd3K62"
    static let clientSecret = "HOPWqKvH8Px6tkhmhbYFzvKBhddbQQlRRXyAurPl"
    static let host = "api.petfinder.com"
    static let grantType = "client_credentials"
    
    static let bodyParams = [
        "client_id": clientId,
        "client_secret": clientSecret,
        "grant_type": grantType
    ]
}
