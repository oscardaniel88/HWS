//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Daniel Camarena on 7/24/23.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
