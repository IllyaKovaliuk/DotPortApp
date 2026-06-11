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

struct VoyageItem: Identifiable, Hashable {
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

    init(from dto: VoyageDTO) {
        id = dto.id
        title = dto.title
        status = dto.status
        departureDate = dto.departureDate
        arrivalDate = dto.arrivalDate
        progressPercent = dto.progressPercent ?? 0
        createdBy = dto.createdBy ?? ""
        createdAt = dto.createdAt
        updatedAt = dto.updatedAt
        userId = dto.userId ?? ""
        routeId = dto.routeId ?? ""
        shipId = dto.shipId ?? ""
        workerId = dto.workerId ?? ""
        portId = dto.portId ?? ""
        containerCounts = dto.containerCounts ?? 0
        fromPort = dto.fromPort ?? ""
        toPort = dto.toPort ?? ""
    }

    init(
        id: String, title: String, status: VoyageStatus,
        departureDate: Date, arrivalDate: Date, progressPercent: Int,
        createdBy: String, createdAt: Date, updatedAt: Date,
        userId: String, routeId: String, shipId: String, workerId: String,
        portId: String, containerCounts: Int, fromPort: String, toPort: String
    ) {
        self.id = id
        self.title = title
        self.status = status
        self.departureDate = departureDate
        self.arrivalDate = arrivalDate
        self.progressPercent = progressPercent
        self.createdBy = createdBy
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.userId = userId
        self.routeId = routeId
        self.shipId = shipId
        self.workerId = workerId
        self.portId = portId
        self.containerCounts = containerCounts
        self.fromPort = fromPort
        self.toPort = toPort
    }
}

struct VoyageDTO: Codable {
    let id: String
    let title: String
    let status: VoyageStatus
    let departureDate: Date
    let arrivalDate: Date
    let progressPercent: Int?
    let createdBy: String?
    let createdAt: Date
    let updatedAt: Date
    let userId: String?
    let routeId: String?
    let shipId: String?
    let workerId: String?
    let portId: String?
    let containerCounts: Int?
    let fromPort: String?
    let toPort: String?
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
            progressPercent: dto.progressPercent ?? 0,
            createdBy: dto.createdBy ?? "",
            createdAt: dto.createdAt,
            updatedAt: dto.updatedAt,
            userId: dto.userId ?? "",
            routeId: dto.routeId ?? "",
            shipId: dto.shipId ?? "",
            workerId: dto.workerId ?? "",
            portId: dto.portId ?? "",
            containerCounts: dto.containerCounts ?? 0,
            fromPort: dto.fromPort ?? "",
            toPort: dto.toPort ?? ""
        )
    }
}
