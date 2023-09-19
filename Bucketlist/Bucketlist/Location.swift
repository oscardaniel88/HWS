//
//  Location.swift
//  Bucketlist
//
//  Created by Daniel Camarena on 9/18/23.
//

import Foundation
import MapKit

struct Location: Equatable, Codable, Identifiable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let example = Location(id: UUID(), name: "Buckingham Palace", description: "Where Queen Elizabeth lives with her dorgis", latitude: 51.501, longitude: -0.141)
    
    static func ==(lhs: Location, rhs:Location) -> Bool {
        lhs.id == rhs.id
    }
}
