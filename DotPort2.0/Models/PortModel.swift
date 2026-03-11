//
//  PortModel.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 17.02.2026.
//

import Foundation
import MapKit

enum BurthStatus: String {
    case opened = "Open"
    case closed = "Closed"
    case NotAvailableNow = "NotAvailableNow"
}


struct PortModel: Identifiable, Equatable {
    var id: String
    var name: String
    var country: String
    var code: String
    var latitude: Double
    var longtitude: Double
    var isActive: Bool = false
    var created_at: Date
    var updated_at: Date
    var burthStatus: BurthStatus
    var shipsCount: Int
    var burthCount: Int
    var description: String?
    
    var coordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
        }
    
}

// ports.count - ports(isActive = true) = available ports


