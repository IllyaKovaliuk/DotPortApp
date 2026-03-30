//
//  PlusViewModel.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 20.03.2026.
//

import Foundation
import SwiftData

class PlusViewModel: ObservableObject{
    var voyage: Voyage
    //    var ports: [PortModel] = []
    @Published var shipId: String = ""
    @Published var fromPort: String = ""
    @Published var toPort: String = ""
    @Published var arrivalDate: Date = Date()
    @Published var departureDate: Date = Date()
    @Published var title: String = ""
    @Published var status: VoyageStatus = .Queued
    @Published var progressPercent: Int = 0
    @Published var createdAt = Date.now
    @Published var updatedAt = Date.now
    @Published var containerCounts: Int = 0

    
       
    init(context: ModelContext, voyage: Voyage? = nil) {
           if let voyage {
               self.voyage = voyage
           } else {
               let newVoyage = Voyage()
               context.insert(newVoyage)
               self.voyage = newVoyage
           }
        
//        let descriptor = FetchDescriptor<PortModel>()
//        self.ports = (try? context.fetch(descriptor)) ?? []
       }
    
    func createVoyage() {
        let voyageActor = GetVoyages()
        
        // 1. Створюємо DTO правильно (використовуємо ініціалізатор структури, а не кортеж)
        // 2. Передаємо конкретне значення статусу (self.status), а не назву типу (VoyageStatus)
        let newVoyage = VoyageDTO(
            id: UUID().uuidString,
            title: title,
            status: self.status, // Передаємо саме змінну зі значенням
            departureDate: departureDate,
            arrivalDate: arrivalDate,
            progressPercent: progressPercent,
            createdBy: "MobileUser",
            createdAt: createdAt,
            updatedAt: updatedAt,
            userId: nil,         // Ці поля ОБОВ'ЯЗКОВІ в ініціалізаторі,
            routeId: nil,        // навіть якщо вони nil у структурі
            shipId: shipId,
            workerId: nil,
            portId: nil,
            containerCounts: containerCounts,
            fromPort: fromPort,
            toPort: toPort
        )
        
        Task {
            do {
                try await voyageActor.postVoyage(newVoyage: newVoyage)
                await MainActor.run {
                    print("✅ Success")
                }
            } catch {
                await MainActor.run {
                    print("❌ Fail: \(error)")
                }
            }
        }
    }
}
