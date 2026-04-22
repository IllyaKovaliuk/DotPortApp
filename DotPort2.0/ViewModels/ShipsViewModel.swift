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
    @Published var isLoading: Bool = false
    @Published var isLoading2: Bool = false
    @Published var ship: ShipModel? = nil
    private var timer: Timer?
    
    init() {
        
    }
    
    
    var countShips: Int {
        let count = ships.count
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
    
//    func containersError(ship: ShipModel) throws {
//        var maxContainers = self.ship.capacityContainers
//        var currentLoad = self.ship.currentLoad
//        
//        guard currentLoad! < maxContainers! else {          //форс анврап можуть бути проблеми
//            throw shipError.invalidCapacity
//        }
//        
//        guard maxContainers! > 0 else{                      //форс анврап можуть бути проблеми
//            throw shipError.invalidCountContainers
//        }
//    }
    
//    
//    func addContainer(oneConatiner: Int){
//        do {
//            try containersError(ship: self.ship)
//            self.ship.currentLoad? += oneConatiner
//            print("Контейнер додано успішно!")
//        } catch {
//            print("Помилка: \(error)")        }
//    }
    
    func fetchShips() async throws {
        
        await MainActor.run { isLoading = true }
        
        do {
            let ships = try await FetchShips().getShips()
            
            await MainActor.run {
                self.ships = ships
                self.isLoading = false
            }
            
        } catch {
            print("Error of loading in shipsViewModel")
            await MainActor.run { isLoading = false }
        }
        
    }
    
    func timerFetch() {
        Task { try await fetchShips() }
        
        timer = Timer.scheduledTimer(withTimeInterval: 300, repeats: true) { _ in
            Task{ try await self.fetchShips() }
        }
    }
    
    func stopAutoUpdate() {
            timer?.invalidate()
        }
    
    
    func fetchShipId(id: String) async throws {
        await MainActor.run { isLoading2 = true }
        
        do {
            let ship = try await FetchShips().getShipId(shipId: id)
            
            await MainActor.run {
                self.ship = ship
                self.isLoading2 = false
            }
            
        } catch {
            print("Error of loading in shipsViewModel")
            await MainActor.run { isLoading2 = false }
        }
    }
    
    func timerFetchId(id: String) {
        Task {
            try await fetchShipId(id: id)
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 300, repeats: true) { _ in
            Task {
                try await self.fetchShipId(id: id)
            }
        }
    }
    
}
