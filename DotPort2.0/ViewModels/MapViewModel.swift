//
//  MapViewModel.swift
//  DotPort2.0
//

import Foundation
import MapKit
import SwiftUI

class MapViewModel: ObservableObject {
    static let shared = MapViewModel()

    var viewModelPorts = PortsViewModel()

    @Published var mapLocation: PortModel? {
        didSet {
            if let location = mapLocation {
                updateMapRegion(location: location)
            }
        }
    }

    @Published var cameraPosition: MapCameraPosition = .automatic
    @Published var connections: [(PortModel, PortModel)] = []
    @Published var showLocationList = false
    @Published var showSheet: PortModel? = nil
    @Published var isReadMore = false

    let mapSpan = MKCoordinateSpan(latitudeDelta: 8, longitudeDelta: 8)

    func setup(with portsVM: PortsViewModel) {
        viewModelPorts = portsVM

        guard !portsVM.ports.isEmpty else { return }

        fitAllPorts(portsVM.ports)

        if mapLocation == nil {
            mapLocation = portsVM.ports.first
        }
    }

    func fitAllPorts(_ ports: [PortModel]) {
        let coords = ports.map(\.validCoordinate).filter { coord in
            coord.latitude != 0 || coord.longitude != 0
        }

        guard !coords.isEmpty else { return }

        if coords.count == 1 {
            cameraPosition = .region(MKCoordinateRegion(center: coords[0], span: mapSpan))
            return
        }

        var minLat = coords[0].latitude
        var maxLat = coords[0].latitude
        var minLng = coords[0].longitude
        var maxLng = coords[0].longitude

        for coord in coords {
            minLat = min(minLat, coord.latitude)
            maxLat = max(maxLat, coord.latitude)
            minLng = min(minLng, coord.longitude)
            maxLng = max(maxLng, coord.longitude)
        }

        let center = CLLocationCoordinate2D(
            latitude: (minLat + maxLat) / 2,
            longitude: (minLng + maxLng) / 2
        )
        let span = MKCoordinateSpan(
            latitudeDelta: max((maxLat - minLat) * 1.5, 2),
            longitudeDelta: max((maxLng - minLng) * 1.5, 2)
        )

        withAnimation(.easeInOut) {
            cameraPosition = .region(MKCoordinateRegion(center: center, span: span))
        }
    }

    private func updateMapRegion(location: PortModel) {
        withAnimation(.easeInOut) {
            cameraPosition = .region(MKCoordinateRegion(
                center: location.validCoordinate,
                span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
            ))
        }
    }

    func toggleList() {
        withAnimation(.easeInOut) {
            showLocationList.toggle()
        }
    }

    func showLocation(location: PortModel) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationList = false

            let reachable = viewModelPorts.graph.reachablePorts(from: location)
            connections = reachable
                .filter { $0.id != location.id }
                .map { (location, $0) }
        }
    }

    func toggleReadMore() {
        withAnimation(.easeInOut) {
            isReadMore.toggle()
        }
    }

    func nextButtonPressed() {
        let ports = viewModelPorts.ports
        guard !ports.isEmpty else { return }

        guard let currentIndex = ports.firstIndex(where: { $0.id == mapLocation?.id }) else {
            showLocation(location: ports[0])
            return
        }

        let nextIndex = (currentIndex + 1) % ports.count
        showLocation(location: ports[nextIndex])
    }
}
