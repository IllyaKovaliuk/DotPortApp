//
//  ShipsViewModel.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 21.02.2026.
//

import Foundation
import SwiftUI


class ShipsViewModel: ObservableObject{
    @Published var ships: [ShipModel] = []
    @Published var ships_data : [ShipModel] = [Mocks.ship1, Mocks.ship2, Mocks.ship3]
    @Published var ship: ShipModel = Mocks.ship1
    
    init() {
        
    }
    
    
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
    
//    func validateContainers(ship: ShipModel, currentLoad: Int){
//        let maxContainers = ship.capacity_containers
//        if currentLoad <= maxContainers {
//            print("We add your container to our ship")
//        } else{
//            Alert(title: Text("Перегруз"))
//        }
//        
//    }
    enum shipError: Error {
        case invalidCountContainers
        case invalidCapacity
        case basicErrror
    }
    
    
    func containersError(ship: ShipModel) throws {
        var maxContainers = self.ship.capacity_containers
        var currentLoad = self.ship.currentLoad
        
        guard currentLoad < maxContainers else {
            throw shipError.invalidCapacity
        }
        
        guard maxContainers > 0 else{
            throw shipError.invalidCountContainers
        }
    }
    
    
    func addContainer(oneConatiner: Int){
        do {
            try containersError(ship: self.ship)
            self.ship.currentLoad += oneConatiner
            print("Контейнер додано успішно!")
        } catch {
            print("Помилка: \(error)")        }
    }
    
}


//var activeVoyagesCount: String {
//let count = voyages.filter {$0.status == Status.In_progress}.count
//return "\(count)"
//}


//    func addContainers(ship: ShipModel, oneContainer: Int){
//        let maxContainers = ship.capacity_containers
//        var currentLoad = ship.currentLoad
//        if maxContainers < 0{
//            throw shipError.invalidCapacity
//        }
//
//        if currentLoad < maxContainers {
//            currentLoad += oneContainer
//            print("We add your container")
//        } else {
//            print("Sorry we cant load container, to much containers")
//        }
//    }
