//
//  ContentView-ViewModel.swift
//  PhotoNamer
//
//  Created by Daniel Camarena on 9/30/23.
//

import Foundation
import SwiftUI

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var showImagePicker = false
        @Published var didSelectImage = false
        @Published var uiImage: UIImage?
        @Published var photoItems: [PhotoItem]
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("PhotoNamer")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                photoItems = try JSONDecoder().decode([PhotoItem].self, from:data)
            } catch {
                photoItems = []
            }
        }
        
        func addImage(photoItem: PhotoItem){
            photoItems.append(photoItem)
            save()
        }
        
        func deleteImage(at offsets: IndexSet) {
            Task {
                @MainActor in
                    let sortedItems = photoItems.sorted()
                    let itemsToDelete = offsets.map { sortedItems[$0] }
                    guard let itemToDelete = itemsToDelete.first else { return }
                    guard let deleteIndex = photoItems.firstIndex(of: itemToDelete) else { return }
                    photoItems.remove(at: deleteIndex)
                    save()
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(photoItems)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data")
            }
        }
        
    }
}
