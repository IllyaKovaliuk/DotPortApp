//
//  ShipsViewModel.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 21.02.2026.
//

import Foundation


class ShipsViewModel: ObservableObject{
    @Published var ships: [ShipModel] = []
    @Published var ships_data : [ShipModel] = [Mocks.ship1, Mocks.ship2, Mocks.ship3]
    
    
    var countShips: Int {
        let count = ships_data.count
        return count
    }
    
    func fuelСalculation(distance: Double, horsepower: Double, weight: Double) -> Double {
        let powerKW = horsepower * 0.735
        let SFOC: Double = 190
        let fuelPerHour = (powerKW * SFOC) / 1000000
        let avarageSpeed = 14.0
        let travelTimeHours = distance / avarageSpeed
        let totalFuel = fuelPerHour * travelTimeHours * 0.75
        return totalFuel
    }
    
    
    
}


//var activeVoyagesCount: String {
//let count = voyages.filter {$0.status == Status.In_progress}.count
//return "\(count)"
//}
