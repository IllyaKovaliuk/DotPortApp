//
//  PortsViewModel.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 20.02.2026.
//

import Foundation
import MapKit

class PortsViewModel: ObservableObject {
    @Published var ports: [PortModel] = []
    @Published var voyages: [VoyageItem] = []
    @Published var ships: [ShipModel] = []
    @Published var isLoading: Bool = false
    @Published var port: PortModel? = nil
    private var timer: Timer?
    let graph = GraphService()

    func parseCoords(port: PortModel) -> CLLocationCoordinate2D {
        port.validCoordinate
    }

    func stats(for port: PortModel) -> PortStats {
        PortStatsCalculator.stats(for: port, voyages: voyages, ships: ships)
    }

    func activeVoyages(for port: PortModel) -> [VoyageItem] {
        PortStatsCalculator.activeVoyages(for: port, from: voyages)
    }

    func fetchPorts() async throws {
        await MainActor.run { isLoading = true }

        do {
            async let portsTask = FetchPorts().getPorts()
            async let voyagesTask = GetVoyages().getVoyages()
            async let shipsTask = FetchShips().getShips()

            let (ports, voyages, ships) = try await (portsTask, voyagesTask, shipsTask)

            await MainActor.run {
                self.ports = ports
                self.voyages = voyages
                self.ships = ships
                self.isLoading = false

                self.graph.buildGraph(from: ports)

                if MapViewModel.shared.mapLocation == nil,
                   let first = ports.first {
                    MapViewModel.shared.setup(with: self)
                }
            }
        } catch {
            print("❌ Error of loading in portsViewModel:", error)
            await MainActor.run { self.isLoading = false }
        }
    }

    func timerFetch() {
        Task { try await fetchPorts() }

        timer = Timer.scheduledTimer(withTimeInterval: 300, repeats: true) { _ in
            Task { try await self.fetchPorts() }
        }
    }

    func fetchPort(id: String) async throws {
        await MainActor.run { isLoading = true }

        do {
            async let portTask = FetchPorts().getPort(portId: id)
            async let voyagesTask = GetVoyages().getVoyages()
            async let shipsTask = FetchShips().getShips()

            let (port, voyages, ships) = try await (portTask, voyagesTask, shipsTask)

            await MainActor.run {
                self.port = port
                self.voyages = voyages
                self.ships = ships
                self.isLoading = false
            }
        } catch {
            print("Error of loading port detail")
            await MainActor.run { isLoading = false }
        }
    }

    func stopAutoUpdate() {
        timer?.invalidate()
    }

    func timerFetchId(id: String) {
        Task { try await fetchPort(id: id) }

        timer = Timer.scheduledTimer(withTimeInterval: 300, repeats: true) { _ in
            Task { try await self.fetchPort(id: id) }
        }
    }
}
