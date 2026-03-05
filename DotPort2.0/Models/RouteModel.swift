//
//  RouteModel.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 17.02.2026.
//

import Foundation


struct RouteModel {
    var RouteId = UUID()
    var fromPortId: PortModel
    var toPortId: PortModel
    var isActive: Bool = false
    var portId: PortModel
    var directionId:DirectionModel
}
