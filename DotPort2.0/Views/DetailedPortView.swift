//
//  DetailedPortView.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 20.02.2026.
//

import SwiftUI
import MapKit

struct DetailedPortView: View {
    let port: PortModel
    @StateObject private var vm = PortsViewModel()
    @StateObject private var voyageVm = VoyageViewModel()
    @State private var region: MKCoordinateRegion
    
    init(port: PortModel){
        self.port = port
        
        _region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: port.latitude , longitude: port.longtitude), span: MKCoordinateSpan(latitudeDelta: 1.5, longitudeDelta: 1.5)
        ))
    }
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 20){
                Map(coordinateRegion: $region, annotationItems: [port]){ item in
                    MapMarker(coordinate: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longtitude), tint:.blue)
                }
                .frame(height: 300)
                .cornerRadius(20.0)
                .padding()
                
                VStack(alignment: .leading) {
                    HStack{
                        Text(port.name)
                            .font(.largeTitle).bold()
                        Spacer()
                        
                        Text(port.burthStatus.rawValue)
                        
                    }
                    Text(port.country)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
            }
            VStack(alignment:.leading, spacing: 20){
                HStack(){
                    VStack{
                        Text("Port of \(port.name)")
//                            ./*padding()*/
//                        Text("Державне підприємство «Оде́ський морськи́й торговельний порт» — один із найбільших українських морських портів, один із найбільших портів в басейні Чорного моря і єдиний порт України який здатний приймати суда класу Panamax")
                            .padding()
                        Spacer()
                    }
                }
                HStack{
                    VStack{
                        Text("\(port.shipsCount)")
                        Text("Active Ships")
                    }
                    Spacer()
                    VStack{
                        Text("\(vm.availableShips)")
                        Text("Available")
                    }
                    Spacer()
                    VStack{
                        Text("\(port.shipsCount)")
                        Text("In queue")
                    }
                }
                .padding()
            }
            LazyVStack {
                ForEach(voyageVm.voyage_data.filter { $0.portId == port.id }) { voyage in
                    VStack(alignment: .leading) {
                        Text(voyage.title).font(.headline)
                        Text("Voyage ID: \(voyage.id)").font(.caption)
                    }
//                    .padding(10)
//                    .background(Color.gray.opacity(0.1))
//                    .cornerRadius(8)
//                    .padding()
//                    .navigationTitle("Voyages in \(port.name)")
                    .fontDesign(.monospaced)
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(red: 43/255, green: 50/255, blue: 63/255))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(10)
                    .shadow(radius: 5)
                    
                    
                }
                .navigationTitle(port.name)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
}


#Preview {
    DetailedPortView(port: PortsViewModel().ports_data[0])
}
