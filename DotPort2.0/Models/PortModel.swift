//
//  PortModel.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 17.02.2026.
//

import Foundation
import MapKit
import SwiftData

enum BerthStatus: String, Codable{
    case opened = "Open"
    case closed = "Closed"
    case NotAvailableNow = "NotAvailableNow"
}


struct PortModel: Identifiable, Equatable, Codable {
    var id: String
    var name: String
    var country: String
    var code: String
    var latitude: Double
    var longtitude: Double
    var isActive: Bool = false
    var createdAt: Date
    var updatedAt: Date
    var berthStatus: BerthStatus
    var shipsCount: Int
    var berthCount: Int
    var description: String?
    
    
    var coordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
        }
    
    
    
}

// ports.count - ports(isActive = true) = available ports


