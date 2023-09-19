//
//  ContentView.swift
//  Bucketlist
//
//  Created by Daniel Camarena on 9/13/23.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct ContentView: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50.0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    @State private var isUnlocked = false
    @State private var locations = [Location]()
    @State private var selectedPlace: Location?
    
    var body: some View {
        ZStack{
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                MapAnnotation(coordinate: location.coordinate){
                    VStack{
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 44, height: 44)
                            .background(.white)
                            .clipShape(Circle())
                            .onTapGesture {
                                selectedPlace = location
                            }
                        
                        Text(location.name)
                            .fixedSize()
                    }
                }
            }
            .ignoresSafeArea()
                .ignoresSafeArea()
            Circle()
                .fill(.red)
                .opacity(0.3)
                .frame(width: 32, height:32)
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button{
                        let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
                        locations.append(newLocation)
                    }label: {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
        }
        .sheet(item: $selectedPlace) { place in
            EditView(location: place) {
                newLocation in
                if let index = locations.firstIndex(of: place){
                    locations[index] = newLocation
                }
            }
        }
       
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "We need to unlock your data"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                success, authenticationError in
                if success {
                    isUnlocked = true
                }else {
                    // there was a problem
                }
            }
        }else {
            // no biometrics
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
