//
//  MapView.swift
//  DotPort2.0
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var vm = MapViewModel.shared
    @StateObject private var portVm = PortsViewModel()

    var body: some View {
        ZStack {
            Map(position: $vm.cameraPosition) {
                ForEach(portVm.ports) { port in
                    Annotation(port.name, coordinate: port.validCoordinate, anchor: .bottom) {
                        PortMapMarker(
                            port: port,
                            isSelected: vm.mapLocation?.id == port.id
                        ) {
                            vm.showLocation(location: port)
                        }
                    }
                }

                ForEach(vm.connections, id: \.1.id) { p1, p2 in
                    MapPolyline(coordinates: [p1.validCoordinate, p2.validCoordinate])
                        .stroke(.blue.opacity(0.7), lineWidth: 2)
                }
            }
            .mapStyle(.standard(elevation: .realistic))

            VStack(spacing: 0) {
                header
                    .padding()

                Spacer()

                if let selected = vm.mapLocation {
                    LocationPrewiewView(location: selected)
                }
            }
        }
        .sheet(item: $vm.showSheet) { sheet in
            LocationDetailedInfo(location: sheet)
        }
        .onAppear {
            vm.setup(with: portVm)
            portVm.timerFetch()
        }
        .onDisappear {
            portVm.stopAutoUpdate()
        }
        .onChange(of: portVm.ports.count) { _, _ in
            vm.setup(with: portVm)
        }
    }
}

private struct PortMapMarker: View {
    let port: PortModel
    let isSelected: Bool
    let onTap: () -> Void

    private var pinColor: Color {
        switch port.berthStatus {
        case .opened: return .green
        case .closed: return .red
        case .NotAvailableNow: return .orange
        }
    }

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 2) {
                Image(systemName: "mappin.circle.fill")
                    .font(.system(size: isSelected ? 36 : 28))
                    .foregroundStyle(pinColor)
                    .shadow(radius: 3)

                Text(port.code)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(isSelected ? Color.blue : Color(.systemBackground))
                    .foregroundColor(isSelected ? .white : .primary)
                    .cornerRadius(6)
                    .shadow(radius: 2)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    MapView()
}

extension MapView {

    private var header: some View {
        VStack {
            Button(action: vm.toggleList) {
                HStack {
                    Image(systemName: "map")
                    Text(headerTitle)
                        .font(.title3)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                    Spacer()
                    Text("\(portVm.ports.count) ports")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Image(systemName: vm.showLocationList ? "chevron.up" : "chevron.down")
                        .font(.caption)
                }
                .frame(height: 55)
                .frame(maxWidth: .infinity)
            }

            if vm.showLocationList {
                ListOfLocations()
                    .frame(maxHeight: 220)
            }
        }
        .padding(.horizontal, 12)
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }

    private var headerTitle: String {
        if let location = vm.mapLocation {
            return "\(location.name), \(location.country)"
        }
        return portVm.isLoading ? "Loading ports…" : "Select a port"
    }
}
