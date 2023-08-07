//
//  DataChallengeApp.swift
//  DataChallenge
//
//  Created by Daniel Camarena on 7/29/23.
//

import SwiftUI

@main
struct DataChallengeApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
