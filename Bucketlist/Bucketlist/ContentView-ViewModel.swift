//
//  ContentView-ViewModel.swift
//  Bucketlist
//
//  Created by Daniel Camarena on 9/23/23.
//

import Foundation
import MapKit
import LocalAuthentication

extension ContentView{
    @MainActor class ViewModel: ObservableObject {
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50.0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        @Published private(set) var locations: [Location]
        @Published var selectedPlace: Location?
        @Published var isUnlocked = false
        @Published var showingError = false
        @Published var errorTitle = ""
        @Published var errorMessage = ""
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from:data)
            } catch {
                locations = []
            }
        }
        
        func addLocation(){
            let newLocation = Location(id:UUID(), name: "New Location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace = selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace){
                locations[index] = location
                save()
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data")
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
                let reason = "We need to unlock your data"
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                    success, authenticationError in
                    if success {
                        Task {
                            @MainActor in
                                self.isUnlocked = true
                        }
                    }else {
                        self.showingError = true
                        self.errorTitle = "There was a problem"
                        self.errorMessage = "\(authenticationError?.localizedDescription ?? "Try again")"
                    }
                }
            }else {
                self.showingError = true
                self.errorTitle = "There was a problem"
                self.errorMessage = "Face ID not supported"
            }
        }
    }
}

