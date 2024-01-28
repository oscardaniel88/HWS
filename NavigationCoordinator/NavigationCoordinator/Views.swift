//
//  Views.swift
//  NavigationCoordinator
//
//  Created by Daniel Camarena on 11/24/23.
//

import SwiftUI

struct MapView: View {
    
    @EnvironmentObject var coordinator: Coordinator<MapRouter>
    
    var body: some View {
        NavigationView {
            Button("Go to the city") {
                coordinator.show(.city(named: "El Paso"))
            }
        }
    }
}


struct CityView: View {
    @EnvironmentObject var coordinator: Coordinator<MapRouter>
    
    let name: String
    
    var body: some View {
        VStack {
            Text(name)
            Button("Back") {
                coordinator.smartDisiss()
            }
        }.navigationBarHidden(true)
    }
}

