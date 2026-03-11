//
//  mocs.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 19.02.2026.
//

import Foundation

//struct Mocks {
//    static let direction = DirectionModel(id: 001, name: "Alania-Odess", created_at: Date())
//    static let route = RouteModel(fromPortId: "002", toPortId: "001", portId: "001", directionId: "001")
//    static let ship = ShipModel(id: "S-505", name: "Ever Given")
//    static let port1 = PortModel(
//        id: 001, name: "Odessa", country: "Ukraine", code: "Od-01", latitude: 51.49, longtitude: 67.32, created_at: Date(), updated_at: Date(), burthStatus: BurthStatus.opened
//    )
//    static let port2 = PortModel(
//        id: 002, name: "Alania", country: "Turkey", code: "Ty-01", latitude: 32.59, longtitude: 97.182, created_at: Date(), updated_at: Date(), burthStatus: BurthStatus.opened
//    )
// сука Route -> Directions -> Ports -> Ships ->

//}

struct Mocks {
    static let direction = DirectionModel(id: 001, name: "Alania-Odessa", created_at: Date())
    
    static let port1 = PortModel(
        id: "001", name: "Odessa", country: "Ukraine", code: "Od-01", latitude: 46.490711, longtitude: 30.746087, created_at: Date(), updated_at: Date(), burthStatus: .closed, shipsCount: 12, burthCount: 11, description: "The Port of Odesa or Odesa Commercial Seaport (Ukrainian: Одеський морський торговельний порт, romanized: Odeskyi morskyi torhovelnyi port), located near Odesa, is the largest Ukrainian seaport and one of the largest ports in the Black Sea basin, with a total annual traffic capacity of 40 million tonnes"
    )
    
    static let port2 = PortModel(
        id: "002", name: "Alania", country: "Turkey", code: "Tu-01", latitude: 36.33, longtitude: 32.00, created_at: Date(), updated_at: Date(), burthStatus: .opened, shipsCount: 10, burthCount: 10
    )
    
    static let port3 = PortModel(
        id: "003", name: "Moldova", country: "Moldova", code: "Mo-01", latitude: 45.28, longtitude: 28.13, created_at: Date(), updated_at: Date(), burthStatus: .opened, shipsCount: 5, burthCount: 10
    )
    static let port4 = PortModel(
        id: "004", name: "Pekin", country: "China", code: "Ch-01", latitude: 38.55 , longtitude: 121.66, created_at: Date(), updated_at: Date(), burthStatus: .opened, shipsCount: 7, burthCount: 11
    )
    
    static let port5 = PortModel(
        id: "005", name: "New-York", country: "USA", code: "Us-01", latitude: 40.67, longtitude: -74.08, created_at: Date(), updated_at: Date(), burthStatus: .opened, shipsCount: 9, burthCount: 10
    )
    
    static let port6 = PortModel(
        id: "006", name: "Italia", country: "Italia", code: "It-01", latitude: 44.40, longtitude: 8.91, created_at: Date(), updated_at: Date(), burthStatus: .opened, shipsCount: 4, burthCount: 10
    )
    static let port7 = PortModel(
        id: "007", name: "Grek", country: "Grek", code: "Gr-01", latitude: 37.94 , longtitude: 23.64, created_at: Date(), updated_at: Date(), burthStatus: .opened, shipsCount: 12, burthCount: 2
    )
    
    static let port8 = PortModel(
        id: "008", name: "Singapore", country: "Singapore", code: "Si-01", latitude: 1.26, longtitude: 103.75, created_at: Date(), updated_at: Date(), burthStatus: .closed, shipsCount: 23, burthCount: 10
    )
    
    static let port9 = PortModel(
        id: "009", name: "Spain", country: "Spain", code: "Sp-01", latitude: 41.35, longtitude: 2.17, created_at: Date(), updated_at: Date(), burthStatus: .opened, shipsCount: 10, burthCount: 10
    )
    
    static let port10 = PortModel(id: "010", name: "Havalimani" , country: "Turkey", code: "Tu-02", latitude: 41.311878, longtitude: 28.782525, created_at: Date(), updated_at: Date(), burthStatus: .opened, shipsCount: 20, burthCount: 10)
    
// 41.311878, 28.782525
    static let route = RouteModel(
        fromPortId: port2,
        toPortId: port1,
        portId: port1,
        directionId: direction
    )
    
    static let ship1 = ShipModel(id: "505", name: "Ever Given", capacity_weight: 10000, capacity_containers: 100, currentLoad: 3, status: .Shipped, portId: "001", currentPortId: "001", engineType: .diesel,  shipType: .Neopanamax, imageName: "file:///Users/illyakovaliuk/Downloads/boat1.jpg" )
    
    static let ship2 = ShipModel(id: "606", name: "Natural Bro", capacity_weight: 25000, capacity_containers: 100, currentLoad: 5, status: .Shipped, portId: "001", currentPortId: "001", engineType: .electric ,  shipType: .Feeder, imageName: "https://i.pinimg.com/736x/92/c7/65/92c7650cef4219e8d5d3e7f8d5708350.jpg")
    
    static let ship3 = ShipModel(id: "707", name: "Funny Advisor", capacity_weight: 25000, capacity_containers: 50, currentLoad: 15, status: .Shipped, portId: "001", currentPortId: "001", engineType: .nuclear,  shipType: .UltraLargeContainerVessels, imageName: "https://i.pinimg.com/736x/46/42/49/4642496649a3df2b854b1723ae8c744b.jpg")
    
//    static let voyage1 = VoyageModel(id: "001", title: "MSC Gülsün", status: .In_progress, departureDate: Date(), arrivalDate: Date(), progressPercent: 65, createdBy:"Illya Kovaliuk", createdAt: Date(), updatedAt: Date(), userId: "001", routeId: "001", shipId: "505", workerId: "001")
//    
//    static let voyage2 = VoyageModel(id: "002", title: "MSC Kovaliuk", status: .In_progress, departureDate: Date(), arrivalDate: Date(), progressPercent: 65, createdBy: "Illya Kovaliuk", createdAt: Date(), updatedAt: Date(), userId: "001", routeId: "001", shipId: "505", workerId: "001")
//    
//    static let voyage3 = VoyageModel(id: "003", title: "MSC Sander", status: .In_progress, departureDate: Date(), arrivalDate: Date(), progressPercent: 65, createdBy: "Illya Kovaliuk", createdAt: Date(), updatedAt: Date(), userId: "001", routeId: "001", shipId: "505", workerId: "001")
}


