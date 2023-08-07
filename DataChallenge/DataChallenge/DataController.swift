//
//  DataController.swift
//  DataChallenge
//
//  Created by Daniel Camarena on 8/6/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "FriendFace")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading data \(error.localizedDescription)")
            }
            
        }
    }
}
