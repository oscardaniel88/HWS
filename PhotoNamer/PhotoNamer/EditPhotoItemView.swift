//
//  EditPhotoItemView.swift
//  PhotoNamer
//
//  Created by Daniel Camarena on 9/30/23.
//

import SwiftUI

struct EditPhotoItemView: View {
    @Environment(\.dismiss) var dismiss
    @State private var photoName = ""
    private var uiImage: UIImage?
    
    var onSave: (PhotoItem) -> Void
    var image: Image? {
        guard let uiImage = uiImage else { return nil }
        return Image(uiImage: uiImage)
    }
    var body: some View {
        NavigationView {
            Form{
                Section {
                    TextField("Type a name", text: $photoName)
                }
                Section{
                    image?
                    .resizable()
                    .scaledToFit()
                }
            }
            .navigationBarTitle("Edit Item", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save"){
                dismiss()
                guard let imageToSave = uiImage else { return }
                let newPhotoItem = PhotoItem(id: UUID(), uiImage: imageToSave, name: photoName)
                onSave(newPhotoItem)
            })
            
        }
    }
    
    init(image: UIImage?, onSave: @escaping(PhotoItem) -> Void){
        self.uiImage = image
        self.onSave = onSave
    }
}

struct EditPhotoItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditPhotoItemView(image: nil){ photoItem in }
    }
}
