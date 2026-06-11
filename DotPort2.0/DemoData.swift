//
//  DemoData.swift
//  DotPort2.0
//

import Foundation

enum DemoData {
    static let ports: [PortModel] = [
        PortModel(id: "port-1", name: "Одеса", country: "Україна", code: "ODS",
                  latitude: 46.490711, longtitude: 30.746087, berthStatus: .opened,
                  shipsCount: 12, berthCount: 11,
                  description: "Головний морський порт України на Чорному морі."),
        PortModel(id: "port-2", name: "Київ", country: "Україна", code: "IEV",
                  latitude: 50.4501, longtitude: 30.5234, berthStatus: .opened,
                  shipsCount: 5, berthCount: 8),
        PortModel(id: "port-4", name: "Стамбул", country: "Туреччина", code: "IST",
                  latitude: 41.0082, longtitude: 28.9784, berthStatus: .opened,
                  shipsCount: 18, berthCount: 15),
        PortModel(id: "port-5", name: "Анталія", country: "Туреччина", code: "AYT",
                  latitude: 36.8969, longtitude: 30.7133, berthStatus: .opened,
                  shipsCount: 9, berthCount: 10),
        PortModel(id: "port-7", name: "Варна", country: "Болгарія", code: "VAR",
                  latitude: 43.2141, longtitude: 27.9147, berthStatus: .opened,
                  shipsCount: 7, berthCount: 9),
        PortModel(id: "port-8", name: "Пірей", country: "Греція", code: "PIR",
                  latitude: 37.942, longtitude: 23.646, berthStatus: .closed,
                  shipsCount: 14, berthCount: 12),
    ]

    static let ships: [ShipModel] = [
        ShipModel(id: "ship-1", name: "Black Pearl", capacityWeight: 120000,
                  capacityContainers: 13000, currentLoad: 8500, status: .Inprogress,
                  portId: "port-1", currentPortId: "port-1",
                  engineType: .diesel, shipType: .neopanamax),
        ShipModel(id: "ship-2", name: "Sea Falcon", capacityWeight: 80000,
                  capacityContainers: 9000, currentLoad: 3200, status: .Notstarted,
                  portId: "port-4", currentPortId: "port-4",
                  engineType: .diesel, shipType: .postPanamax),
        ShipModel(id: "ship-3", name: "MSC Gülsün", capacityWeight: 200000,
                  capacityContainers: 23000, currentLoad: 15000, status: .Shipped,
                  portId: "port-1", currentPortId: "port-5",
                  engineType: .diesel, shipType: .ultraLarge),
        ShipModel(id: "ship-4", name: "Odessa Star", capacityWeight: 65000,
                  capacityContainers: 7000, currentLoad: 4100, status: .Inprogress,
                  portId: "port-7", currentPortId: "port-7",
                  engineType: .electric, shipType: .feeder),
    ]

    static let voyages: [VoyageItem] = [
        VoyageItem(
            id: "voy-1", title: "Одеса → Стамбул", status: .InProgress,
            departureDate: Date().addingTimeInterval(-86400 * 2),
            arrivalDate: Date().addingTimeInterval(86400 * 3),
            progressPercent: 65, createdBy: "Illya Kovaliuk",
            createdAt: Date().addingTimeInterval(-86400 * 5),
            updatedAt: Date(), userId: "u-1", routeId: "route-1",
            shipId: "ship-1", workerId: "w-1", portId: "port-1",
            containerCounts: 450, fromPort: "Одеса", toPort: "Стамбул"
        ),
        VoyageItem(
            id: "voy-2", title: "Варна → Одеса", status: .InProgress,
            departureDate: Date().addingTimeInterval(-86400),
            arrivalDate: Date().addingTimeInterval(86400 * 2),
            progressPercent: 40, createdBy: "Illya Kovaliuk",
            createdAt: Date().addingTimeInterval(-86400 * 3),
            updatedAt: Date(), userId: "u-1", routeId: "route-3",
            shipId: "ship-4", workerId: "w-4", portId: "port-7",
            containerCounts: 280, fromPort: "Варна", toPort: "Одеса"
        ),
        VoyageItem(
            id: "voy-3", title: "Стамбул → Анталія", status: .Queued,
            departureDate: Date().addingTimeInterval(86400 * 2),
            arrivalDate: Date().addingTimeInterval(86400 * 5),
            progressPercent: 0, createdBy: "Illya Kovaliuk",
            createdAt: Date(), updatedAt: Date(), userId: "u-1", routeId: "route-2",
            shipId: "ship-2", workerId: "w-2", portId: "port-4",
            containerCounts: 120, fromPort: "Стамбул", toPort: "Анталія"
        ),
    ]

    static func port(id: String) -> PortModel? {
        ports.first { $0.id == id }
    }

    static func ship(id: String) -> ShipModel? {
        ships.first { $0.id == id }
    }
}
