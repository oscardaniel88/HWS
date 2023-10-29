//
//  Card.swift
//  FlashZilla
//
//  Created by Daniel Camarena on 10/28/23.
//

import Foundation

struct Card: Codable {
    let prompt: String
    let answer: String
    
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
