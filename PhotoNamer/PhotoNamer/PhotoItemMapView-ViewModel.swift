//
//  PhotoItemMapView-ViewModel.swift
//  PhotoNamer
//
//  Created by Daniel Camarena on 10/1/23.
//

import Foundation
import SwiftUI
import MapKit

extension PhotoItemMapView {
    @MainActor class ViewModel: ObservableObject {
        var photoItem: PhotoItem
        @Published var mapRegion: MKCoordinateRegion
        @Published var showingDetailView = false
        
        init(photoItem: PhotoItem, mapRegion: MKCoordinateRegion){
            self.photoItem = photoItem
            self.mapRegion = mapRegion
        }
    }
}
