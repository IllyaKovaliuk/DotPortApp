////
////  DetailedPortView.swift
////  DotPort2.0
////
////  Created by Illya Kovaliuk on 20.02.2026.
////
//
//import SwiftUI
//import MapKit
//import SwiftData
//
//struct DetailedPortView: View {
//    let port: PortModel
//    @StateObject private var vm = PortsViewModel()
//    @StateObject private var voyageVm = VoyageViewModel()
//    @Query var voyages: [Voyage]
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 50.45, longitude: 30.52),
//        span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
//    )
//    
//    init(port: PortModel){
//        self.port = port
//        
//        let portId = port.id
//                _voyages = Query(filter: #Predicate<Voyage> { voyage in
//                    voyage.portId == portId
//                })
//        
//        _region = State(initialValue: MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: port.latitude, longitude: port.longtitude ?? 0), span: MKCoordinateSpan(latitudeDelta: 1.5, longitudeDelta: 1.5)
//        ))
//    }
//    
//    var body: some View {
//        ScrollView{
//            VStack(alignment: .leading, spacing: 20){
//                Map(coordinateRegion: $region, annotationItems: [port]) { item in
//                    MapMarker(coordinate: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longtitude ?? 0), tint: .blue)
//                }
//                .frame(height: 300)
//                .cornerRadius(20.0)
//                .padding()
//                
//                VStack(alignment: .leading) {
//                    HStack{
//                        Text(port.name)
//                            .font(.largeTitle).bold()
//                        Spacer()
//                        
//                        Text(port.berthStatus.rawValue)
//                        
//                    }
//                    Text(port.country)
//                        .foregroundColor(.secondary)
//                }
//                .padding(.horizontal)
//            }
//            VStack(alignment:.leading, spacing: 20){
//                HStack(){
//                    VStack{
//                        Text("Port of \(port.name)")
////                            ./*padding()*/
////                        Text("Державне підприємство «Оде́ський морськи́й торговельний порт» — один із найбільших українських морських портів, один із найбільших портів в басейні Чорного моря і єдиний порт України який здатний приймати суда класу Panamax")
//                            .padding()
//                        Spacer()
//                    }
//                }
//                HStack{
//                    VStack{
//                        Text("\(port.shipsCount)")
//                        Text("Active Ships")
//                    }
//                    Spacer()
//                    VStack{
////                        Text("\(vm.availableShips)")
//                        Text("Available")
//                    }
//                    Spacer()
//                    VStack{
//                        Text("\(port.shipsCount)")
//                        Text("In queue")
//                    }
//                }
//                .padding()
//            }
//            LazyVStack {
//                ForEach(voyages) { voyage in
//                    VStack(alignment: .leading) {
//                        Text(voyage.title).font(.headline)
//                        Text("Voyage ID: \(voyage.id)").font(.caption)
//                    }
////                    .padding(10)
////                    .background(Color.gray.opacity(0.1))
////                    .cornerRadius(8)
////                    .padding()
////                    .navigationTitle("Voyages in \(port.name)")
//                    .fontDesign(.monospaced)
//                    .foregroundStyle(.primary)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding()
//                    .background(Color(red: 43/255, green: 50/255, blue: 63/255))
//                    .foregroundColor(.white)
//                    .cornerRadius(12)
//                    .padding(10)
//                    .shadow(radius: 5)
//                    
//                    
//                }
//                .navigationTitle(port.name)
//                .navigationBarTitleDisplayMode(.inline)
//            }
//        }
//    }
//    
//}
//


//
//  DetailedPortView.swift
//  DotPort2.0
//

import SwiftUI
import MapKit

struct DetailedPortView: View {
    let port: PortModel

    @StateObject private var vm = PortsViewModel()

    @State private var region = PortModel.safeMapRegion(
        for: PortModel(id: "", name: "", country: "", code: "")
    )

    init(port: PortModel) {
        self.port = port
        _region = State(initialValue: PortModel.safeMapRegion(for: port))
    }

    private var stats: PortStats {
        vm.stats(for: port)
    }

    private var displayedVoyages: [VoyageItem] {
        Array(vm.activeVoyages(for: port).prefix(5))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                // MARK: - Map

                Map(coordinateRegion: $region, annotationItems: [port]) { item in
                    MapMarker(
                        coordinate: item.validCoordinate,
                        tint: .blue
                    )
                }
                .frame(height: 260)
                .cornerRadius(24)
                .padding(.horizontal)
                .padding(.top, 12)

                // MARK: - Header

                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(port.name)
                                .font(.largeTitle)
                                .fontWeight(.bold)

                            Text(port.country)
                                .font(.headline)
                                .foregroundColor(.secondary)
                        }

                        Spacer()

                        Text(port.berthStatus.rawValue)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(Color.green.opacity(0.15))
                            .foregroundColor(.green)
                            .cornerRadius(14)
                    }

                    Text("Port of \(port.name)")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.top, 8)

                    Text(portDescription)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineSpacing(4)
                }
                .padding(.horizontal)

                // MARK: - Statistics

                VStack(alignment: .leading, spacing: 14) {
                    Text("Port Statistics")
                        .font(.title2)
                        .fontWeight(.bold)

                    HStack(spacing: 12) {
                        PortStatCard(
                            title: "Active Voyages",
                            value: "\(stats.activeVoyages)",
                            icon: "ferry.fill"
                        )

                        PortStatCard(
                            title: "Berths",
                            value: "\(stats.totalBerths)",
                            icon: "dock.rectangle"
                        )

                        PortStatCard(
                            title: "In Queue",
                            value: "\(stats.inQueue)",
                            icon: "clock.fill"
                        )
                    }
                }
                .padding(.horizontal)

                // MARK: - Quick Information

                VStack(alignment: .leading, spacing: 14) {
                    Text("Quick Information")
                        .font(.title2)
                        .fontWeight(.bold)

                    VStack(spacing: 12) {
                        InfoRow(
                            icon: "location.fill",
                            title: "Country",
                            value: port.country
                        )

                        InfoRow(
                            icon: "number",
                            title: "Port Code",
                            value: port.code
                        )

                        InfoRow(
                            icon: "mappin.and.ellipse",
                            title: "Coordinates",
                            value: "\(String(format: "%.4f", port.validCoordinate.latitude)), \(String(format: "%.4f", port.validCoordinate.longitude))"
                        )

                        InfoRow(
                            icon: "checkmark.seal.fill",
                            title: "Operational Status",
                            value: port.berthStatus.rawValue
                        )

                        InfoRow(
                            icon: "shippingbox.fill",
                            title: "Cargo Type",
                            value: "Container Cargo"
                        )
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                }
                .padding(.horizontal)

                // MARK: - Active Voyages

                VStack(alignment: .leading, spacing: 14) {
                    HStack {
                        Text("Active Voyages")
                            .font(.title2)
                            .fontWeight(.bold)

                        Spacer()

                        Text("\(stats.activeVoyages)")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(Color.blue.opacity(0.15))
                            .foregroundColor(.blue)
                            .cornerRadius(10)
                    }

                    if displayedVoyages.isEmpty {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("No active voyages")
                                .font(.headline)

                            Text("There are currently no voyages connected with this port.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(18)
                    } else {
                        ForEach(displayedVoyages) { voyage in
                            VoyageSmallCard(voyage: voyage)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
        .navigationTitle(port.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { vm.timerFetchId(id: port.id) }
        .onDisappear { vm.stopAutoUpdate() }
    }

    private var portDescription: String {
        """
        \(port.name) is used as one of the main logistics points in the DotPort system. \
        The port stores operational information about ships, active voyages, berth availability \
        and current cargo processing activity.
        """
    }
}

// MARK: - Components

struct PortStatCard: View {
    let title: String
    let value: String
    let icon: String

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)

            Text(value)
                .font(.title2)
                .fontWeight(.bold)

            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 18)
        .background(Color(.systemGray6))
        .cornerRadius(18)
    }
}

struct InfoRow: View {
    let icon: String
    let title: String
    let value: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 24)

            Text(title)
                .foregroundColor(.secondary)

            Spacer()

            Text(value)
                .fontWeight(.semibold)
                .multilineTextAlignment(.trailing)
        }
        .font(.subheadline)
    }
}

struct VoyageSmallCard: View {
    let voyage: VoyageItem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(voyage.title)
                .font(.headline)

            Text("\(voyage.fromPort) → \(voyage.toPort)")
                .font(.caption)
                .foregroundColor(.white.opacity(0.75))

            HStack {
                Text("Status")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))

                Spacer()

                Text(voyage.status.title)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.white.opacity(0.15))
                    .cornerRadius(10)
            }
        }
        .fontDesign(.monospaced)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(red: 43/255, green: 50/255, blue: 63/255))
        .cornerRadius(16)
        .shadow(radius: 4)
    }
}
