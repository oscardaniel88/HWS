//
//  Items.swift
//  PhotoNamer
//
//  Created by Daniel Camarena on 9/30/23.
//

import Foundation
import SwiftUI

struct PhotoItem: Equatable, Identifiable, Codable {
    enum CodingKeys: String, CodingKey {
        case id, image, name
    }
    var id: UUID
    var uiImage: UIImage
    var name: String
    
    static func ==(lhs: PhotoItem, rhs: PhotoItem) -> Bool {
        lhs.id == rhs.id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        let imageData = try container.decode(Data.self, forKey: .image)
        let uiImage = UIImage(data: imageData)
        self.uiImage = uiImage!
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    init(id: UUID, uiImage: UIImage, name: String){
        self.id = id
        self.uiImage = uiImage
        self.name = name
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        let imageData = uiImage.jpegData(compressionQuality: 0.8)
        try container.encode(imageData, forKey: .image)
        try container.encode(name, forKey: .name)
    }
    
}
