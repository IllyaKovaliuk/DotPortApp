//
//  VoyageModel.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 17.02.2026.
//

import Foundation

//enum VoyageStatus: String {
//    case In_progress = "In progress"
//    case Shipped = "Shipped"
//    case Not_started = "Not started"
//    case Queued = "Queued"
//}

enum VoyageStatus: Int, Comparable, CaseIterable {
    static func < (lhs: VoyageStatus, rhs: VoyageStatus) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    case Queued = 0
    case InProgress = 1
    case Shipped = 2
    case Done = 3
}

struct VoyageModel: Identifiable, Hashable {
    let id: String
    var title: String
    var status: VoyageStatus
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
    
    static let voyage1 = VoyageModel(id: "001", title: "MSC Gülsün", status: .InProgress, departureDate: Date(), arrivalDate: Date(), progressPercent: 65, createdBy:"Illya Kovaliuk", createdAt: Date(), updatedAt: Date(), userId: "001", routeId: "001", shipId: "505", workerId: "001", portId: "001", containerCounts: 10, fromPort: "001", toPort: "002")
    
    static let voyage2 = VoyageModel(id: "002", title: "MSC Kovaliuk", status: .Shipped, departureDate: Date(), arrivalDate: Date(), progressPercent: 65, createdBy: "Illya Kovaliuk", createdAt: Date(), updatedAt: Date(), userId: "001", routeId: "001", shipId: "505", workerId: "001", portId: "001", containerCounts: 30, fromPort: "001", toPort: "002")
    
    static let voyage3 = VoyageModel(id: "003", title: "MSC Sander", status: .Queued, departureDate: Date(), arrivalDate: Date(), progressPercent: 65, createdBy: "Illya Kovaliuk", createdAt: Date(), updatedAt: Date(), userId: "001", routeId: "001", shipId: "505", workerId: "001", portId: "003", containerCounts: 100, fromPort: "003", toPort: "004")
}
