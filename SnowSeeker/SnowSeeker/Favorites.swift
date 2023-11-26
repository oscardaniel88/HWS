//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Daniel Camarena on 11/22/23.
//

import Foundation

class Favorites: ObservableObject {
    private var resorts: Set<String>
    
    private let saveKey = "Favorites"
    
    init() {
        // Challenge 2
        resorts = []
        if let data = UserDefaults.standard.data(forKey: saveKey){
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
                resorts = decoded
            }
        }
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        // Challenge 2
        if let data = try? JSONEncoder().encode(resorts) {
            UserDefaults.standard.set(data, forKey: saveKey)
        }
    }
}
