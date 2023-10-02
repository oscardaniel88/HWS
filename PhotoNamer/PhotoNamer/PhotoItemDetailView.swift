//
//  PhotoItemDetailView.swift
//  PhotoNamer
//
//  Created by Daniel Camarena on 10/1/23.
//

import SwiftUI

struct PhotoItemDetailView: View {
    private var photoItem: PhotoItem
    var body: some View {
        VStack{
            Image(uiImage: photoItem.uiImage)
                .resizable()
                .scaledToFit()
            Text(photoItem.name)
                .font(.headline)
        }
    }
    init(photoItem: PhotoItem){
        self.photoItem = photoItem
    }
}

struct PhotoItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoItemDetailView(photoItem: PhotoItem(id: UUID(), uiImage: UIImage(), name: "TEST"))
    }
}
