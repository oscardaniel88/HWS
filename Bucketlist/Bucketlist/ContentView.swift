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
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack{
            if(viewModel.isUnlocked){
                Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                    MapAnnotation(coordinate: location.coordinate){
                        VStack{
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(Circle())
                                .onTapGesture {
                                    viewModel.selectedPlace = location
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
                            viewModel.addLocation()
                            viewModel.save()
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
            } else {
                Button("Unlock Places"){
                    viewModel.authenticate()
                }
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }
        .sheet(item: $viewModel.selectedPlace) { place in
            EditView(location: place) {
                viewModel.update(location: $0)
                viewModel.save()
            }
        }
       
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
