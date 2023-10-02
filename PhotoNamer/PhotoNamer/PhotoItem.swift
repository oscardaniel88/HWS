//
//  Items.swift
//  PhotoNamer
//
//  Created by Daniel Camarena on 9/30/23.
//

import Foundation
import SwiftUI
import MapKit

struct PhotoItem: Equatable, Identifiable, Codable, Comparable {
    enum CodingKeys: String, CodingKey {
        case id, image, name, latitude, longitude
    }
    var id: UUID
    var uiImage: UIImage
    var name: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func ==(lhs: PhotoItem, rhs: PhotoItem) -> Bool {
        lhs.id == rhs.id
    }
    
    static func < (lhs: PhotoItem, rhs: PhotoItem) -> Bool {
        lhs.name < rhs.name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        let imageData = try container.decode(Data.self, forKey: .image)
        let uiImage = UIImage(data: imageData)
        self.uiImage = uiImage!
        self.name = try container.decode(String.self, forKey: .name)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
    }
    
    init(id: UUID, uiImage: UIImage, name: String, latitude: Double, longitude: Double){
        self.id = id
        self.uiImage = uiImage
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        let imageData = uiImage.jpegData(compressionQuality: 0.8)
        try container.encode(imageData, forKey: .image)
        try container.encode(name, forKey: .name)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
    
}
