//
//  MapViewModel.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 07.03.2026.
//

import Foundation
import MapKit
import SwiftUI

class MapViewModel: ObservableObject{
    @Published var connections: [(PortModel, PortModel)] = []
    static let shared = MapViewModel()
        
        // Повертаємо ініціалізацію, але БЕЗ @StateObject (це тільки для View)
        var viewModelPorts = PortsViewModel()
        
        // Робимо мапЛокейшн опціональним, щоб не було крашу при старті
        @Published var mapLocation: PortModel? {
            didSet {
                if let location = mapLocation {
                    updateMapRegion(location: location)
                }
            }
        }

        @Published var cameraPosition: MapCameraPosition = .automatic
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)

    init(){
        
    }
    
    func setup(with portsVM: PortsViewModel) {
            self.viewModelPorts = portsVM
            
            // Якщо порти вже є (наприклад, завантажились раніше)
            if let first = portsVM.ports.first {
                self.mapLocation = first
                self.updateMapRegion(location: first)
            }
        }
    
    private func updateMapRegion(location: PortModel) {
        print("Перемикаю на: \(location.name), коорд: \(location.coordinate.latitude), \(location.coordinate.longitude)")
            DispatchQueue.main.async {
                withAnimation(.easeInOut) {
                    self.cameraPosition = .region(MKCoordinateRegion(
                        center: location.coordinate,
                        span: self.mapSpan
                    ))
                }
            }
        }
    
//    private func updateToFirstPort() {
//            if let firstPort = viewModelPorts?.ports.first {
//                self.mapLocation = firstPort
//                self.mapRegion = MKCoordinateRegion(
//                    center: firstPort.coordinate,
//                    span: mapSpan
//                )
//            }
//        }
    

    //список локацій
    @Published var showLocationList: Bool = false
    // show sheet
    @Published var showSheet: PortModel? = nil
    
    //список локацій
    func toggleList(){
        print("toggled")
        withAnimation(.easeInOut) {
            showLocationList = !showLocationList
        }
    }
    
//    func showLocation(location: PortModel){
//        withAnimation(.easeInOut) {
//            mapLocation = location
//            showLocationList = false
//        }
//    }
    
    func showLocation(location: PortModel){
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationList = false
            
            // 🔥 ГРАФ ЛОГІКА
            let reachable = viewModelPorts.graph.reachablePorts(from: location)
            
            connections = reachable
                .filter { $0.id != location.id }
                .map { (location, $0) }
        }
    }
    
    @Published var isReadMore: Bool = false
    
    func toggleReadMore(){
        print("Toggled")
        withAnimation(.easeInOut){
            isReadMore = !isReadMore
        }
    }
    
    func readMore(location: PortModel){
        withAnimation(.easeInOut){
            
        }
    }
    
    
    func nextButtonPressed(){
        guard let currentIndex = viewModelPorts.ports.firstIndex (where: { $0 == mapLocation }) else {
            print("Could not find current index in location array.")
            return
        }
        
        let nextIndex = currentIndex + 1
        guard ((viewModelPorts.ports.indices.contains(nextIndex)) != nil) else {
            guard let firstLocation = viewModelPorts.ports.first else { return }
            showLocation(location: firstLocation)
            return
        }
        
        let nextLocation = viewModelPorts.ports[nextIndex]
        showLocation(location: nextLocation)
        
    }
}
