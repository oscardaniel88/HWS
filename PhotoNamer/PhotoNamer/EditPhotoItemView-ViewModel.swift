//
//  EditPhotoItemView-ViewModel.swift
//  PhotoNamer
//
//  Created by Daniel Camarena on 10/1/23.
//

import Foundation

import Foundation
import SwiftUI

extension EditPhotoItemView {
    @MainActor class ViewModel: ObservableObject {
        @Published var photoName = ""
        var uiImage: UIImage?
        let locationFetcher: LocationFetcher
        var image: Image? {
            guard let uiImage = uiImage else { return nil }
            return Image(uiImage: uiImage)
        }
        var latitude: Double {
            return locationFetcher.lastKnownLocation?.latitude ?? 0.0
        }
        
        var longitude: Double {
            return locationFetcher.lastKnownLocation?.longitude ?? 0.0
        }
        
        init(uiImage: UIImage?, locationFetcher: LocationFetcher){
            self.uiImage = uiImage
            self.locationFetcher = locationFetcher
        }
        
        func updatePhotoItem() -> PhotoItem {
            return PhotoItem(id: UUID(), uiImage: uiImage ?? UIImage(), name: photoName, latitude: latitude, longitude: longitude)
        }
    }
}
