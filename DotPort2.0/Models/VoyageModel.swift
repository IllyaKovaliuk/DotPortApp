//
//  VoyageModel.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 17.02.2026.
//

import Foundation
import SwiftData

//enum VoyageStatus: String {
//    case In_progress = "In progress"
//    case Shipped = "Shipped"
//    case Not_started = "Not started"
//    case Queued = "Queued"
//}

//enum VoyageStatus2: Int, Comparable, CaseIterable {
//    static func < (lhs: VoyageStatus2, rhs: VoyageStatus2) -> Bool {
//        return lhs.rawValue < rhs.rawValue
//    }
//    
//    case Queued = 0
//    case InProgress = 1
//    case Shipped = 2
//    case Done = 3
//}



//struct VoyageModel: Identifiable, Hashable {
//    let id: String
//    var title: String
//    var status: VoyageStatus
//    var departureDate: Date
//    var arrivalDate: Date
//    var progressPercent: Int
//    var createdBy: String
//    var createdAt: Date
//    var updatedAt: Date
//    var userId: String
//    var routeId: String
//    var shipId: String
//    var workerId: String
//    var portId: String
//    var containerCounts: Int
//    var fromPort: String
//    var toPort: String
//    
//
//}


//extension VoyageModel {
//    
//    static let voyage1 = VoyageModel(id: "001", title: "MSC Gülsün", status: .InProgress, departureDate: Date(), arrivalDate: Date(), progressPercent: 65, createdBy:"Illya Kovaliuk", createdAt: Date(), updatedAt: Date(), userId: "001", routeId: "001", shipId: "505", workerId: "001", portId: "001", containerCounts: 10, fromPort: "001", toPort: "002")
//    
//    static let voyage2 = VoyageModel(id: "002", title: "MSC Kovaliuk", status: .Shipped, departureDate: Date(), arrivalDate: Date(), progressPercent: 65, createdBy: "Illya Kovaliuk", createdAt: Date(), updatedAt: Date(), userId: "001", routeId: "001", shipId: "505", workerId: "001", portId: "001", containerCounts: 30, fromPort: "001", toPort: "002")
//    
//    static let voyage3 = VoyageModel(id: "003", title: "MSC Sander", status: .Queued, departureDate: Date(), arrivalDate: Date(), progressPercent: 65, createdBy: "Illya Kovaliuk", createdAt: Date(), updatedAt: Date(), userId: "001", routeId: "001", shipId: "505", workerId: "001", portId: "003", containerCounts: 100, fromPort: "003", toPort: "004")
//}


enum VoyageStatus: Int, Codable, CaseIterable {
    case Queued = 0
    case InProgress = 1
    case Shipped = 2
    case Done = 3
    
    var title: String {
        switch self {
        case .Queued:     return "Queued"
        case .InProgress: return "In Progress"
        case .Shipped:    return "Shipped"
        case .Done:       return "Done"
        }
    }
}

struct VoyageDTO: Codable {
    let id: String
    let title: String
    let status: Int // На сервері статус зазвичай Int
    let departureDate: Date
    let arrivalDate: Date
    let progressPercent: Int
    let createdBy: String
    let createdAt: Date
    let updatedAt: Date
    let userId: String?
    let routeId: String?
    let shipId: String?
    let workerId: String?
    let portId: String?
    let containerCounts: Int
    let fromPort: String
    let toPort: String
}

@Model
final class Voyage {
    @Attribute(.unique) var id: String
    
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

    // Relationships (якщо будеш додавати пізніше)
//    @Relationship(deleteRule: .cascade) var vessel: Vessel?
//    @Relationship(deleteRule: .cascade) var rate: Rate?
    
            init(
                id: String = UUID().uuidString,
                title: String = "",
                status: VoyageStatus = .InProgress,
                departureDate: Date = .now,
                arrivalDate: Date = .now.addingTimeInterval(86400), // +1 день
                progressPercent: Int = 0,
                createdBy: String = "",
                createdAt: Date = Date(),
                updatedAt: Date = Date(),
                userId: String = "",
                routeId: String = "",
                shipId: String = "",
                workerId: String = "",
                portId: String = "",
                containerCounts: Int = 0,
                fromPort: String = "",
                toPort: String = ""
            ) {
                self.id = id
                self.title = title // +
                self.status = status
                self.departureDate = departureDate // +
                self.arrivalDate = arrivalDate // +
                self.progressPercent = progressPercent
                self.createdBy = createdBy
                self.createdAt = Date()
                self.updatedAt = Date()
                self.userId = userId // choose captain
                self.routeId = routeId //-
                self.shipId = shipId // choose ship
                self.workerId = workerId
                self.portId = portId
                self.containerCounts = containerCounts
                self.fromPort = fromPort
                self.toPort = toPort
            }
    
    convenience init(from dto: VoyageDTO) {
        self.init(
            id: dto.id,
            title: dto.title,
            status: VoyageStatus(rawValue: dto.status) ?? .InProgress, // Твій Enum
            departureDate: dto.departureDate,
            arrivalDate: dto.arrivalDate,
            progressPercent: dto.progressPercent,
            createdBy: dto.createdBy,
            createdAt: dto.createdAt,
            updatedAt: dto.updatedAt,
            userId: dto.userId ?? "",
            routeId: dto.routeId ?? "",
            shipId: dto.shipId ?? "",
            workerId: dto.workerId ?? "",
            portId: dto.portId ?? "",
            containerCounts: dto.containerCounts,
            fromPort: dto.fromPort,
            toPort: dto.toPort
        )
    }
}


// MARK: - Extension для конвертації між старою і новою моделлю

extension Voyage {
    
    // Стара модель → Нова модель (для збереження в SwiftData)
//    convenience init(from old: VoyageModel) {
//        self.init(
//            id: old.id,
//            title: old.title,
//            status: old.status,
//            departureDate: old.departureDate,
//            arrivalDate: old.arrivalDate,
//            progressPercent: old.progressPercent,
//            createdBy: old.createdBy,
//            userId: old.userId,
//            routeId: old.routeId,
//            shipId: old.shipId,
//            workerId: old.workerId,
//            portId: old.portId,
//            containerCounts: old.containerCounts,
//            fromPort: old.fromPort,
//            toPort: old.toPort
//        )
//    }
    
    // Нова модель → Стара модель (для сумісності зі старими ViewModel)
//    func toOldModel() -> VoyageModel {
//        return VoyageModel(
//            id: self.id,
//            title: self.title,
//            status: self.status,
//            departureDate: self.departureDate,
//            arrivalDate: self.arrivalDate,
//            progressPercent: self.progressPercent,
//            createdBy: self.createdBy,
//            createdAt: self.createdAt,
//            updatedAt: self.updatedAt,
//            userId: self.userId,
//            routeId: self.routeId,
//            shipId: self.shipId,
//            workerId: self.workerId,
//            portId: self.portId,
//            containerCounts: self.containerCounts,
//            fromPort: self.fromPort,
//            toPort: self.toPort
//        )
//    }
    
}
