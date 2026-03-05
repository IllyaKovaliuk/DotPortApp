//
//  PortsViewModel.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 20.02.2026.
//

import Foundation


class PortsViewModel: ObservableObject{
    @Published var ports: [PortModel] = []
    @Published var ports_data: [PortModel] = [Mocks.port1, Mocks.port2, Mocks.port3, Mocks.port4, Mocks.port5, Mocks.port6, Mocks.port7, Mocks.port8, Mocks.port9]
    @Published var ships: [ShipModel] = []
    @Published var ships_data: [ShipModel] = [Mocks.ship1]
    
    var availableShips: Int {
        var count = 0
        for ship in ships_data{
            if ship.status.rawValue == "Shipped"{
                count += 1
            }
        }
        return count
    }
    
    
}
