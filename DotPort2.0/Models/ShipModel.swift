//
//  ShipModel.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 17.02.2026.
//

import Foundation

enum StatusChoose: String, Codable, Hashable {
    case Inprogress = "In_progress"
    case Shipped = "Shipped"
    case Notstarted = "Not_started"
}

enum EngineType: String, Codable, Hashable {
    case diesel = "diesel"
    case gasTurbine = "gasturbine"
    case electric = "electric"
    case nuclear = "nuclearturbine"
}

enum ShipType: String, Codable, Hashable {
        case ultraLarge = "UltraLargeContainerVessels"
        case neopanamax = "Neopanamax"
        case postPanamax = "PostPanamax"
        case feeder = "Feeder"
        case barges = "Barges"
    
}





struct ShipModel: Identifiable, Codable, Hashable {
    var id: String
    var name: String
    var capacityWeight: Float?
    var capacityContainers: Int?
    var currentLoad: Int?
    var status: StatusChoose?
    var portId: String?
    var currentPortId: String?
    var engineType: EngineType?
    var shipType: ShipType?
    var imageName: String?

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        id = try c.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        name = try c.decodeIfPresent(String.self, forKey: .name) ?? ""
        capacityWeight = try c.decodeIfPresent(Float.self, forKey: .capacityWeight)
        capacityContainers = try c.decodeIfPresent(Int.self, forKey: .capacityContainers)
        currentLoad = try c.decodeIfPresent(Int.self, forKey: .currentLoad)
        status = try c.decodeIfPresent(StatusChoose.self, forKey: .status)
        portId = try c.decodeIfPresent(String.self, forKey: .portId)
        currentPortId = try c.decodeIfPresent(String.self, forKey: .currentPortId)
        engineType = try c.decodeIfPresent(EngineType.self, forKey: .engineType)
        shipType = try c.decodeIfPresent(ShipType.self, forKey: .shipType)
        imageName = try c.decodeIfPresent(String.self, forKey: .imageName)
    }

    init(
        id: String = UUID().uuidString,
        name: String,
        capacityWeight: Float? = nil,
        capacityContainers: Int? = nil,
        currentLoad: Int? = nil,
        status: StatusChoose? = nil,
        portId: String? = nil,
        currentPortId: String? = nil,
        engineType: EngineType? = nil,
        shipType: ShipType? = nil,
        imageName: String? = nil
    ) {
        self.id = id
        self.name = name
        self.capacityWeight = capacityWeight
        self.capacityContainers = capacityContainers
        self.currentLoad = currentLoad
        self.status = status
        self.portId = portId
        self.currentPortId = currentPortId
        self.engineType = engineType
        self.shipType = shipType
        self.imageName = imageName
    }

    var estimatedPower: Double {
        switch shipType {
        case .barges: return 100
        case .feeder: return 300
        case .postPanamax: return 2500
        case .neopanamax: return 6000
        case .ultraLarge: return 15000
        case .none: return 0
        }
    }
}
