//
//  PhotoItemDetailView.swift
//  PhotoNamer
//
//  Created by Daniel Camarena on 10/1/23.
//

import SwiftUI

struct PhotoItemDetailView: View {
    @Environment(\.dismiss) var dismiss
    private var photoItem: PhotoItem
    var body: some View {
        NavigationView {
            VStack{
                Image(uiImage: photoItem.uiImage)
                    .resizable()
                    .scaledToFit()
                Text(photoItem.name)
                    .font(.headline)
            }
            .navigationBarTitle(photoItem.name, displayMode: .inline)
            .navigationBarItems(leading: Button("Close"){
                dismiss()
            })
            
        }
    }
    init(photoItem: PhotoItem){
        self.photoItem = photoItem
    }
}

struct PhotoItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoItemDetailView(photoItem: PhotoItem(id: UUID(), uiImage: UIImage(), name: "TEST", latitude: 0.5, longitude: 0.0))
    }
}
