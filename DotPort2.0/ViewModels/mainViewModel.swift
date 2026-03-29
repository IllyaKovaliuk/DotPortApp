//
//  mainViewModel.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 19.02.2026.
//

import Foundation
import SwiftData

enum Tab{
    case dashboard, ports, ships, profile, plus
}

class MainVM: ObservableObject {
    @Published var voyages: [Voyage] = []
        @Published var ports: [PortModel] = [] 
        @Published var currentPage: Tab = .dashboard
        
        // Функція, яка забирає дані з бази
        func fetchData(context: ModelContext) {
            let voyageDescriptor = FetchDescriptor<Voyage>(sortBy: [SortDescriptor(\.createdAt)])
            do {
                self.voyages = try context.fetch(voyageDescriptor)
            } catch {
                print("Не вдалося завантажити вояжі: \(error)")
            }
        }
    
    var activeVoyagesCount: String {
        let count = voyages.filter {$0.status == VoyageStatus.InProgress}.count
        return "\(count)"
    }
    
    var queueShips: String {
        let countQueuedShips = voyages.filter {$0.status == VoyageStatus.Queued}.count
        return "\(countQueuedShips)"
    }
    
    var berthAvailability: String {
        let countOpenBurth = ports.filter { $0.berthStatus == BerthStatus.opened}.count
        return "\(countOpenBurth)"
    }
    
    
}
