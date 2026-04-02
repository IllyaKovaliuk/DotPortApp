//
//  VoyageModel.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 17.02.2026.
//

import Foundation
import SwiftData


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
    let status: VoyageStatus // На сервері статус зазвичай Int
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
            status: VoyageStatus(rawValue: dto.status.rawValue) ?? .InProgress, // Твій Enum
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
