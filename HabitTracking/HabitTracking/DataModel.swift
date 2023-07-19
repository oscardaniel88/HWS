//
//  DataModel.swift
//  HabitTracking
//
//  Created by Daniel Camarena on 7/19/23.
//

import Foundation

struct Activity: Codable, Identifiable, Equatable {
    var id = UUID()
    let name: String
    let description: String
    var timesCompleted = 0
}

class Activities: ObservableObject {
    @Published var items = [Activity]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey: "activities")
            }
        }
    }
    init() {
        if let savedActivities = UserDefaults.standard.data(forKey: "activities") {
            if let decoded = try? JSONDecoder().decode([Activity].self, from: savedActivities) {
                items = decoded
            }
        }else {
            items = []
        }
    }
}
