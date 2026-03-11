//
//  mainViewModel.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 19.02.2026.
//

import Foundation

enum Tab{
    case dashboard, ports, ships, profile, plus
}

class MainVM: ObservableObject {
    @Published var voyages: [VoyageModel] = [VoyageModel.voyage1, VoyageModel.voyage2, VoyageModel.voyage3]
    @Published var ports: [PortModel] = [Mocks.port1, Mocks.port2]
    @Published var currentPage: Tab = .dashboard
    
    
    var activeVoyagesCount: String {
        let count = voyages.filter {$0.status == VoyageStatus.InProgress}.count
        return "\(count)"
    }
    
    var queueShips: String {
        let countQueuedShips = voyages.filter {$0.status == VoyageStatus.Queued}.count
        return "\(countQueuedShips)"
    }
    
    var berthAvailability: String {
        let countOpenBurth = ports.filter { $0.burthStatus == BurthStatus.opened}.count
        return "\(countOpenBurth)"
    }
    
    
}
