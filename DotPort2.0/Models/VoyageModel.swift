//
//  VoyageModel.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 17.02.2026.
//

import Foundation

enum Status: String {
    case In_progress = "In progress"
    case Shipped = "Shipped"
    case Not_started = "Not started"
    case Queued = "Queued"
}

struct VoyageModel: Identifiable, Hashable {
    let id: String
    var title: String
    var status: Status
    var departureDate: Date
    var arrivalDate: Date
    var progressPercent: Int
    var createdBy: String
    var createdAt: Date
    var updatedAt: Date
    var userId: String
    var routeId: String
    var shipId: String
    var workerId: String
    var portId: String
    var containerCounts: Int
    var fromPort: String
    var toPort: String
    

}


extension VoyageModel {
//    static let mockVoyage = VoyageModel(
//        id: UUID().uuidString,
//        title: "North Atlantic Route",
//        status: Status.Queued,
//        departureDate: Date(),
//        arrivalDate: Date().addingTimeInterval(86400 * 7), // +7 днів
//        progressPercent: 45,
//        createdBy: "admin_01",
//        createdAt: Date(),
//        updatedAt: Date(),
//        userId: "user_123",
//        routeId: "route_456",
//        shipId: "ship_789",
//        workerId: "worker_101"
//    )
//    
//    static let mockVoyage2 = VoyageModel(
//        id: UUID().uuidString,
//        title: "North Atlantic Route",
//        status: Status.Queued,
//        departureDate: Date(),
//        arrivalDate: Date().addingTimeInterval(86400 * 7), // +7 днів
//        progressPercent: 80,
//        createdBy: "admin_01",
//        createdAt: Date(),
//        updatedAt: Date(),
//        userId: "user_123",
//        routeId: "route_456",
//        shipId: "ship_789",
//        workerId: "worker_101"
//    )
//    
//    static let mockVoyage3 = VoyageModel(
//        id: UUID().uuidString,
//        title: "North Atlantic Route",
//        status: Status.Shipped,
//        departureDate: Date(),
//        arrivalDate: Date().addingTimeInterval(86400 * 7), // +7 днів
//        progressPercent: 78,
//        createdBy: "admin_01",
//        createdAt: Date(),
//        updatedAt: Date(),
//        userId: "user_123",
//        routeId: "route_456",
//        shipId: "ship_789",
//        workerId: "worker_101"
//    )
//    
//    static let mockVoyage4 = VoyageModel(
//        id: UUID().uuidString,
//        title: "South Atlantic Route",
//        status: Status.Queued,
//        departureDate: Date(),
//        arrivalDate: Date().addingTimeInterval(86400 * 7), // +7 днів
//        progressPercent: 45,
//        createdBy: "admin_01",
//        createdAt: Date(),
//        updatedAt: Date(),
//        userId: "user_123",
//        routeId: "route_213",
//        shipId: "ship_789",
//        workerId: "worker_101"
//    )
    
    static let voyage1 = VoyageModel(id: "001", title: "MSC Gülsün", status: .In_progress, departureDate: Date(), arrivalDate: Date(), progressPercent: 65, createdBy:"Illya Kovaliuk", createdAt: Date(), updatedAt: Date(), userId: "001", routeId: "001", shipId: "505", workerId: "001", portId: "001", containerCounts: 10, fromPort: "001", toPort: "002")
    
    static let voyage2 = VoyageModel(id: "002", title: "MSC Kovaliuk", status: .Shipped, departureDate: Date(), arrivalDate: Date(), progressPercent: 65, createdBy: "Illya Kovaliuk", createdAt: Date(), updatedAt: Date(), userId: "001", routeId: "001", shipId: "505", workerId: "001", portId: "001", containerCounts: 30, fromPort: "001", toPort: "002")
    
    static let voyage3 = VoyageModel(id: "003", title: "MSC Sander", status: .Not_started, departureDate: Date(), arrivalDate: Date(), progressPercent: 65, createdBy: "Illya Kovaliuk", createdAt: Date(), updatedAt: Date(), userId: "001", routeId: "001", shipId: "505", workerId: "001", portId: "003", containerCounts: 100, fromPort: "003", toPort: "004")
}
