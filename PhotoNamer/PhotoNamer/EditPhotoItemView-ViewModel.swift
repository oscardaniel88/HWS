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
        var image: Image? {
            guard let uiImage = uiImage else { return nil }
            return Image(uiImage: uiImage)
        }
        
        init(uiImage: UIImage?){
            self.uiImage = uiImage
        }
        
        func save() -> PhotoItem? {
            guard let imageToSave = uiImage else { return nil }
            return PhotoItem(id: UUID(), uiImage: imageToSave, name: photoName)
        }
    }
}
