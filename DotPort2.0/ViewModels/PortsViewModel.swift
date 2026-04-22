//
//  PortsViewModel.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 20.02.2026.
//

import Foundation
import MapKit


class PortsViewModel: ObservableObject{
    @Published var ports: [PortModel] = []
    @Published var ships: [ShipModel] = []
    @Published var isLoading: Bool = false
    @Published var port: PortModel? = nil
    private var timer: Timer?
    let graph = GraphService()
    
    func parseCoords(port: PortModel) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(
            latitude: port.latitude,
            longitude: port.longtitude
        )
    }
    
    func fetchPorts() async throws {
        await MainActor.run { isLoading = true }
        
        do {
            let ports = try await FetchPorts().getPorts()
            
            await MainActor.run {
                self.ports = ports
                self.isLoading = false
                
                self.graph.buildGraph(from: ports)
                
                if MapViewModel.shared.mapLocation == nil,
                   let first = ports.first {
                    MapViewModel.shared.setup(with: self)
                }
            }
            
        } catch {
            print("Error of loading in portsViewModel")
            
            await MainActor.run {
                self.isLoading = false
            }
        }
    }
    
    func timerFetch() {
        Task { try await fetchPorts() }
        
        timer = Timer.scheduledTimer(withTimeInterval: 300, repeats: true) { _ in
            Task{ try await self.fetchPorts()  }
        }
    }
    
    func fetchPort(id: String) async throws {
        await MainActor.run {isLoading = true}
        
        do{
            let port = try await FetchPorts().getPort(portId: id)
            
            await MainActor.run {
                self.port = port
                self.isLoading = false
        }}
        catch {
            print("Error of loading in shipsViewModel")
            await MainActor.run { isLoading = false }
        }
    }
    func stopAutoUpdate() {
            timer?.invalidate()
        }
    
    
    func timerFetchId(id: String) {
        Task {
            try await fetchPort(id: id)
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 300, repeats: true) { _ in
            Task {
                try await self.fetchPort(id: id)
            }
        }
    }
}
