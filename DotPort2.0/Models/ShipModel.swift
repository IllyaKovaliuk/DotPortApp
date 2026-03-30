//
//  ShipModel.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 17.02.2026.
//

import Foundation

enum StatusChoose: String, Codable {
    case In_progress = "In progress"
    case Shipped = "Shipped"
    case Not_started = "Not started"
}

enum EngineType: String, Codable {
    case diesel = "diesel"
    case gasTurbine = "Gas turbine"
    case electric = "electric"
    case nuclear = "nuclear turbine"
}

enum ShipType: String, Codable {
    case UltraLargeContainerVessels = "Ultra Large Container Vessels (ULCV)" //Місткість: 14,500 – 24,000+ контейнерів (TEU).
    case Neopanamax = "Neopanamax(Standart)" //Місткість: 10,000 – 14,500 TEU.
    case PostPanamax = "Post-Panamax" //Місткість: 5,000 – 10,000 TEU.
    case Feeder = "Feeder" //Місткість: 1,000 – 3,000 TEU.
    case Barges = "Barges" //Місткість: До 1,000 TEU (часто 100-300).
    
}



struct ShipModel: Identifiable, Codable, Hashable{
    var id : String
    var name: String
    var capacity_weight: Float
    var capacity_containers: Int
    var currentLoad: Int
    var status: StatusChoose
    var portId: /*PortModel*/ String
    var currentPortId: /*PortModel*/ String
    var engineType: EngineType
    var shipType: ShipType
    var estimatedPower: Double {
        switch shipType {
        case .Barges: return 100
        case .Feeder: return 300
        case .PostPanamax: return 2500
        case .Neopanamax: return 6000
        case .UltraLargeContainerVessels: return 15000
        }
    }
    var imageName: String? 
}
