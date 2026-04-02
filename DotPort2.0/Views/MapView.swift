//
//  MapView.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 07.03.2026.
//

import SwiftUI
import MapKit



struct MapView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = MapViewModel.shared
    @StateObject var portVm = PortsViewModel()
    private var mapRegion: MKCoordinateRegion {
        let coordinate = portVm.ports.isEmpty ?
                         CLLocationCoordinate2D(latitude: 0, longitude: 0) :
        portVm.ports[0].coordinate
        
        return MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    }
    var body: some View {
        ZStack {
            Map(position: $vm.cameraPosition)
            
            VStack(spacing: 0) {
                header
                    .padding()
                
                Spacer()
                
                ZStack{
                    ForEach(portVm.ports){port in
//                        Marker(port.name, coordinate: port.coordinate)
                        
                        if vm.mapLocation == port{
                            LocationPrewiewView(location: port)
                        }
                    }
                }
            }
        }
        .sheet(item: $vm.showSheet, onDismiss: nil) { sheet in
            LocationDetailedInfo(location: sheet)
        }
        
    }
}


#Preview {
    MapView()
}


extension MapView {
    
    private var header: some View {
        VStack {
            Button(action: vm.toggleList) {
                Text(vm.mapLocation!.name + ", " + vm.mapLocation!.country)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation!)
                    .onTapGesture {
                        vm.showLocationList.toggle()
                    }
            }
            
            if vm.showLocationList{
                ListOfLocations()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
    
    
}
