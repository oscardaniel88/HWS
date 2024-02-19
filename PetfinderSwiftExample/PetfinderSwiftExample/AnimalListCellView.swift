//
//  AnimalListCellView.swift
//  PetfinderSwiftExample
//
//  Created by Daniel Camarena on 2/19/24.
//

import SwiftUI

struct AnimalListCellView: View {
    let photos: [Photo]?
    let name: String
    var body: some View {
            HStack{
                AsyncImage(url: URL(string: photos?.first?.small ?? "")){ image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 50, maxHeight: 50)
                        
                } placeholder: {
                    Color.gray
                }
                .frame(width: 50, height: 50)
                Text(name)
                Spacer()
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
    }
}

#Preview {
    AnimalListCellView(photos: [Photo](), name: "Test")
}
