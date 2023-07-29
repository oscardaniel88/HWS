//
//  UsersUtils.swift
//  DataChallenge
//
//  Created by Daniel Camarena on 7/29/23.
//

import Foundation

struct Friend: Codable, Identifiable {
    var id: UUID
    var name: String
}

struct User: Codable, Identifiable  {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
}
