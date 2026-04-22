//
//  VoyageViewModel.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 22.02.2026.
//

import Foundation
import MapKit
import SwiftData

class VoyageViewModel: ObservableObject {
    @Published var voyages: [Voyage] = []
    @Published var isLoading: Bool = false
    private var timer: Timer?
    
    init(){
        
    }
    
//    func statusValidate(voyage: Voyage, nextStatus: VoyageStatus){
//        if nextStatus > voyage.status {
//            print("200 Ok")
//        } else {
//            print("404 Bad")
//        }
//    }
    
//    func fetchVoyages(context: ModelContext) {
//            let descriptor = FetchDescriptor<Voyage>()
//            self.voyages = (try? context.fetch(descriptor)) ?? []
//        }
//    
    func fetchVoyages() async throws {
        await MainActor.run{ isLoading = true }
        
        do {
            let voyages = try await GetVoyages().getVoyages()
            
            await MainActor.run {
                self.voyages = voyages
                self.isLoading = false
            }
        }catch DecodingError.keyNotFound(let key, let context) {
            print("❌ Помилка: ключ '\(key.stringValue)' не знайдений. Контекст: \(context.debugDescription)")
        } catch DecodingError.typeMismatch(let type, let context) {
            print("❌ Помилка: невідповідність типу \(type). Контекст: \(context.debugDescription)")
        } catch {
            print("❌ Інша помилка декодування: \(error)")
            await MainActor.run { isLoading = false }
        }
    }
    
    func timerFetching() {
        Task{try await fetchVoyages()}
        
        timer = Timer.scheduledTimer(withTimeInterval: 300, repeats: true) { _ in
            Task{ try await self.fetchVoyages()  }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    func takeLong(port: PortModel) -> CLLocationDegrees{
        let longtitude = port.longtitude
        return longtitude
    }
    
    func takeLat(port: PortModel) -> CLLocationDegrees{
        let latitude = port.latitude
        return latitude
    }
    
//    func progressBarCalc(voyage: VoyageModel) -> Double {
//        let allCases = VoyageStatus.allCases
//        
//
//    }
//    var progress : Double {
//        let allCases = VoyageStatus.allCases
//        guard let index = allCases.firstIndex(of: voyage.status) else {
//            return 0
//        }
//        return Double(index + 1) / Double(allCases.count)
//    }
    
    
//    func addSampleData(context: ModelContext) {
//        let voyage1 = Voyage(id: "001", title: "MSC Gülsün", status: .InProgress, departureDate: Date(), arrivalDate: Date(), progressPercent: 65, createdBy:"Illya Kovaliuk", /*createdAt: Date(), updatedAt: Date(),*/ userId: "001", routeId: "001", shipId: "505", workerId: "001", portId: "001", containerCounts: 10, fromPort: "001", toPort: "002")
//        
//        let voyage2 = Voyage(id: "002", title: "MSC Kovaliuk", status: .Shipped, departureDate: Date(), arrivalDate: Date(), progressPercent: 65, createdBy: "Illya Kovaliuk", /*createdAt: Date(), updatedAt: Date(),*/ userId: "001", routeId: "001", shipId: "505", workerId: "001", portId: "001", containerCounts: 30, fromPort: "001", toPort: "002")
//        
//        let voyage3 = Voyage(id: "003", title: "MSC Sander", status: .Queued, departureDate: Date(), arrivalDate: Date(), progressPercent: 65, createdBy: "Illya Kovaliuk", /*createdAt: Date(), updatedAt: Date(),*/ userId: "001", routeId: "001", shipId: "505", workerId: "001", portId: "003", containerCounts: 100, fromPort: "003", toPort: "004")
//        context.insert(voyage1)
//        context.insert(voyage2)
//        context.insert(voyage3)
//    }
    
}
