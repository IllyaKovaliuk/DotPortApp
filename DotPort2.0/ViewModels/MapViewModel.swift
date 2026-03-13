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
    static let shared = MapViewModel()
    @Published var ports: [PortModel] = [Mocks.port1, Mocks.port2, Mocks.port3, Mocks.port4, Mocks.port5, Mocks.port6, Mocks.port7, Mocks.port8, Mocks.port9, Mocks.port10]
    @Published var port: PortModel = Mocks.port1
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    @Published var cameraPosition: MapCameraPosition = .automatic
    @Published var mapLocation: PortModel {
            didSet {
                updateMapRegion(location: mapLocation)
            }
        }

    init(){
        let firstPort = [Mocks.port1, Mocks.port2, Mocks.port3, Mocks.port4, Mocks.port5, Mocks.port10][0]
                self.mapLocation = firstPort
 
                self.updateMapRegion(location: firstPort)
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
    
    private func updateToFirstPort() {
            if let firstPort = ports.first {
                self.mapLocation = firstPort
                self.mapRegion = MKCoordinateRegion(
                    center: firstPort.coordinate,
                    span: mapSpan
                )
            }
        }
    

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
    
    func showLocation(location: PortModel){
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationList = false
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
        guard let currentIndex = ports.firstIndex (where: { $0 == mapLocation }) else {
            print("Could not find current index in location array.")
            return
        }
        
        let nextIndex = currentIndex + 1
        guard ports.indices.contains(nextIndex) else {
            guard let firstLocation = ports.first else { return }
            showLocation(location: firstLocation)
            return
        }
        
        let nextLocation = ports[nextIndex]
        showLocation(location: nextLocation)
        
    }
}
