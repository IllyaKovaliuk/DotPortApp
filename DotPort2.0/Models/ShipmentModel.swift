//
//  ShipmentModel.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 17.02.2026.
//

import Foundation

enum Cargos: String {
    case UltraLargeContainerVessels = "Ultra Large Container Vessels (ULCV)" //Місткість: 14,500 – 24,000+ контейнерів (TEU).
    case Neopanamax = "Neopanamax(Standart)" //Місткість: 10,000 – 14,500 TEU.
    case PostPanamax = "Post-Panamax" //Місткість: 5,000 – 10,000 TEU.
    case Feeder = "Feeder" //Місткість: 1,000 – 3,000 TEU.
    case Barges = "Barges" //Місткість: До 1,000 TEU (часто 100-300).
    
}


struct ShipmentModel {
    var shipmentId = UUID()
    var cargoType: Cargos
    var cargoWeight: Float
    var cargoDescription: String
    var contactInfo: String
    var tracingCode: String
    var created_at: Date
    var voyageId: Voyage
}
