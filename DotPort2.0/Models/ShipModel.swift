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





struct ShipModel: Identifiable, Codable, Hashable{
    var id = UUID().uuidString
    var name: String
    var capacityWeight: Float?
    var capacityContainers: Int?
    var currentLoad: Int?
    var status: StatusChoose?
    var portId: /*PortModel*/ String?
    var currentPortId: /*PortModel*/ String?
    var engineType: EngineType?
    var shipType: ShipType
    
    var estimatedPower: Double {
        switch shipType {
        case .barges: return 100
        case .feeder: return 300
        case .postPanamax: return 2500
        case .neopanamax: return 6000
        case .ultraLarge: return 15000
        }
    }
    var imageName: String? 
}
