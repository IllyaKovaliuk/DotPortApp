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
        id: "001", name: "Odessa", country: "Ukraine", code: "Od-01", latitude: 46.490711, longtitude: 30.746087, createdAt: Date(), updatedAt: Date(), berthStatus: .closed, shipsCount: 12, berthCount: 11, description: "The Port of Odesa or Odesa Commercial Seaport (Ukrainian: Одеський морський торговельний порт, romanized: Odeskyi morskyi torhovelnyi port), located near Odesa, is the largest Ukrainian seaport and one of the largest ports in the Black Sea basin, with a total annual traffic capacity of 40 million tonnes."
    )
    
    static let port2 = PortModel(
        id: "002", name: "Alania", country: "Turkey", code: "Tu-01", latitude: 36.33, longtitude: 32.00, createdAt: Date(), updatedAt: Date(), berthStatus: .opened, shipsCount: 10, berthCount: 10, description: "Based on the search results, does not refer to a standard, widely recognized technical network port or specific geographic port name. It appears to be a name associated with vessels (e.g., General Cargo ship Alina, IMO 8027901) or a company name like Alinea Customs, which provides import/export clearance services at UK ports."
    )
    
    static let port3 = PortModel(
        id: "003", name: "Moldova", country: "Moldova", code: "Mo-01", latitude: 45.28, longtitude: 28.13, createdAt: Date(), updatedAt: Date(), berthStatus: .opened, shipsCount: 5, berthCount: 10, description: "The Giurgiulești International Free Port (GIFP) is the only port in Moldova accessible to seagoing vessels, located on the Danube River (km 133.8) at its confluence with the Prut River. It serves as a vital strategic, logistics, and Free Economic Zone hub, featuring oil, grain, and container terminals that facilitate international trade."
    )
    static let port4 = PortModel(
        id: "004", name: "Pekin", country: "China", code: "Ch-01", latitude: 38.55 , longtitude: 121.66, createdAt: Date(), updatedAt: Date(), berthStatus: .opened, shipsCount: 7, berthCount: 11, description: "Beijing serves as a major logistics hub connected to the sea primarily through the nearby Port of Tianjin, located about 120 km southeast. Key facilities include the Tianjin International Cruise Home Port (serving tourists) and extensive container terminals for international trade. The region relies on the Beijing-Tianjin-Hebei port integration."
    )
    
    static let port5 = PortModel(
        id: "005", name: "New-York", country: "USA", code: "Us-01", latitude: 40.67, longtitude: -74.08, createdAt: Date(), updatedAt: Date(), berthStatus: .opened, shipsCount: 9, berthCount: 10, description: "The Port of New York and New Jersey is the largest container port on the U.S. East Coast and a top-three busiest in the nation, serving as a primary maritime gateway for1,500 square miles (3,900 km) of consumer markets. Situated in the New York-New Jersey Harbor Estuary, it features over 770 miles (1,240 km) of shoreline and handles diverse, high-volume cargo via advanced, 24-hour terminals."
    )
    
    static let port6 = PortModel(
        id: "006", name: "Genoa", country: "Italia", code: "It-01", latitude: 44.40, longtitude: 8.91, createdAt: Date(), updatedAt: Date(), berthStatus: .opened, shipsCount: 4, berthCount: 10, description: "Italian ports are critical Mediterranean logistics hubs with a rich history, managing 70% of the country's exported goods and significant passenger traffic. Major, highly specialized ports include the top container hub Gioia Tauro, the busiest multipurpose port in Genoa, the industrial hub of La Spezia, and the primary cruise gateway in Civitavecchia."
    )
    static let port7 = PortModel(
        id: "007", name: "Piraeus", country: "Greece", code: "Gr-01", latitude: 37.94 , longtitude: 23.64, createdAt: Date(), updatedAt: Date(), berthStatus: .opened, shipsCount: 12, berthCount: 2, description: "Greece's ports are vital maritime hubs, led by the Port of Piraeus (largest passenger port in Europe and main Athens gateway) and the Port of Thessaloniki (Northern Greece's industrial hub). Key ports for Aegean island access include Rafina, Lavrio, and Heraklion (Crete), while Patras serves as the primary gateway to Italy. "
    )
    
    static let port8 = PortModel(
        id: "008", name: "Singapore", country: "Singapore", code: "Si-01", latitude: 1.26, longtitude: 103.75, createdAt: Date(), updatedAt: Date(), berthStatus: .closed, shipsCount: 23, berthCount: 10, description: "The Port of Singapore is the world's busiest transshipment hub and second-busiest container port, handling roughly 15-20% of global container throughput and half of the world's annual crude oil. Located at the Strait of Malacca, it connects to over 600 ports in 120+ countries, with 140,000+ vessel calls annually."
    )
    
    static let port9 = PortModel(
        id: "009", name: "Barcelona", country: "Spain", code: "Sp-01", latitude: 41.35, longtitude: 2.17, createdAt: Date(), updatedAt: Date(), berthStatus: .opened, shipsCount: 10, berthCount: 10, description: "Spain has one of Europe's most important port systems, with 46, general-interest ports managed by 28 authorities, handling over 86% of national trade and 16.4 million containers annually. Key hubs include the Mediterranean-focused Port of Valencia, the strategic Port of Algeciras, and the versatile Port of Barcelona."
    )
    
    static let port10 = PortModel(id: "010", name: "Havalimani" , country: "Turkey", code: "Tu-02", latitude: 41.311878, longtitude: 28.782525, createdAt: Date(), updatedAt: Date(), berthStatus: .opened, shipsCount: 20, berthCount: 10, description: "Is a massive, modern international airport in Arnavutköy, Istanbul, serving as Turkey's main gateway. Opened in 2018, it features a 1.44 million m² terminal (the world's third-largest), with a current 90 million annual passenger capacity planned to reach 200 million upon full completion."
    )
    

    static let route = RouteModel(
        fromPortId: port2,
        toPortId: port1,
        portId: port1,
        directionId: direction
    )
    
//    static let ship1 = ShipModel(id: UUID(), name: "Ever Given", capacityWeight: 10000, capacityContainers: 100, currentLoad: 3, status: .Shipped, portId: "001", currentPortId: "001", engineType: .diesel,  shipType: .Neopanamax, imageName: "file:///Users/illyakovaliuk/Downloads/boat1.jpg" )
//    
//    static let ship2 = ShipModel(id: UUID(), name: "Natural Bro", capacityWeight: 25000, capacityContainers: 100, currentLoad: 5, status: .Shipped, portId: "001", currentPortId: "001", engineType: .electric ,  shipType: .Feeder, imageName: "https://i.pinimg.com/736x/92/c7/65/92c7650cef4219e8d5d3e7f8d5708350.jpg")
//    
//    static let ship3 = ShipModel(id: UUID(), name: "Funny Advisor", capacityWeight: 25000, capacityContainers: 50, currentLoad: 15, status: .Shipped, portId: "001", currentPortId: "001", engineType: .nuclear,  shipType: .UltraLargeContainerVessels, imageName: "https://i.pinimg.com/736x/46/42/49/4642496649a3df2b854b1723ae8c744b.jpg")
    
//    static let voyage1 = VoyageModel(id: "001", title: "MSC Gülsün", status: .In_progress, departureDate: Date(), arrivalDate: Date(), progressPercent: 65, createdBy:"Illya Kovaliuk", createdAt: Date(), updatedAt: Date(), userId: "001", routeId: "001", shipId: "505", workerId: "001")
//    
//    static let voyage2 = VoyageModel(id: "002", title: "MSC Kovaliuk", status: .In_progress, departureDate: Date(), arrivalDate: Date(), progressPercent: 65, createdBy: "Illya Kovaliuk", createdAt: Date(), updatedAt: Date(), userId: "001", routeId: "001", shipId: "505", workerId: "001")
//    
//    static let voyage3 = VoyageModel(id: "003", title: "MSC Sander", status: .In_progress, departureDate: Date(), arrivalDate: Date(), progressPercent: 65, createdBy: "Illya Kovaliuk", createdAt: Date(), updatedAt: Date(), userId: "001", routeId: "001", shipId: "505", workerId: "001")
    
}


