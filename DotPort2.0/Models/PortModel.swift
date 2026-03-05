//
//  PortModel.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 17.02.2026.
//

import Foundation

enum BurthStatus: String {
    case opened = "Open"
    case closed = "Closed"
    case NotAvailableNow = "NotAvailableNow"
}


struct PortModel: Identifiable {
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
    
}

// ports.count - ports(isActive = true) = available ports


