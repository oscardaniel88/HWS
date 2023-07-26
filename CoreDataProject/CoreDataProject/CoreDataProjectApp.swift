//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Daniel Camarena on 7/25/23.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @StateObject var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
