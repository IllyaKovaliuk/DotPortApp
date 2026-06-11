//
//  DetailedVoyageView.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 19.02.2026.
//

import SwiftUI
import MapKit

private struct VoyageMapPin: Identifiable {
    let id: String
    let title: String
    let coordinate: CLLocationCoordinate2D
}

struct DetailedVoyageView: View {
    let voyage: VoyageItem

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 46.49, longitude: 30.74),
        span: MKCoordinateSpan(latitudeDelta: 8, longitudeDelta: 8)
    )

    private var durationHours: Int {
        max(Int(voyage.arrivalDate.timeIntervalSince(voyage.departureDate) / 3600), 0)
    }

    private var mapPins: [VoyageMapPin] {
        [
            VoyageMapPin(id: "from", title: voyage.fromPort, coordinate: coordinate(for: voyage.fromPort)),
            VoyageMapPin(id: "to", title: voyage.toPort, coordinate: coordinate(for: voyage.toPort))
        ]
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                headerSection
                progressSection
                mapSection
                infoGridSection
                detailsSection
            }
            .padding(.vertical)
        }
        .background(Color(red: 0.98, green: 0.98, blue: 0.96))
        .navigationTitle("Вояж")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { centerMapOnRoute() }
    }

    private var headerSection: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 6) {
                Text(voyage.title)
                    .font(.title.bold())
                Text("\(voyage.fromPort) → \(voyage.toPort)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text(voyage.status.title)
                .font(.caption.bold())
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(statusColor.opacity(0.15))
                .foregroundStyle(statusColor)
                .cornerRadius(10)
        }
        .padding(.horizontal)
    }

    private var progressSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Прогрес")
                    .font(.headline)
                Spacer()
                Text("\(voyage.progressPercent)%")
                    .font(.headline)
                    .foregroundStyle(.blue)
            }

            ProgressView(value: Double(voyage.progressPercent), total: 100)
                .tint(.blue)

            HStack {
                Label(voyage.departureDate.formatted(date: .abbreviated, time: .omitted), systemImage: "arrow.up.right")
                Spacer()
                Label(voyage.arrivalDate.formatted(date: .abbreviated, time: .omitted), systemImage: "flag.checkered")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.04), radius: 8, y: 2)
        .padding(.horizontal)
    }

    private var mapSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Маршрут")
                .font(.headline)
                .padding(.horizontal)

            Map(coordinateRegion: $region, annotationItems: mapPins) { pin in
                MapMarker(coordinate: pin.coordinate, tint: pin.id == "from" ? .green : .blue)
            }
            .frame(height: 240)
            .cornerRadius(16)
            .padding(.horizontal)
        }
    }

    private var infoGridSection: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            infoCard(icon: "shippingbox.fill", title: "Контейнери", value: "\(voyage.containerCounts)")
            infoCard(icon: "clock.fill", title: "Тривалість", value: "\(durationHours) год")
            infoCard(icon: "ferry.fill", title: "Судно", value: shortId(voyage.shipId))
            infoCard(icon: "person.fill", title: "Капітан", value: shortId(voyage.workerId))
        }
        .padding(.horizontal)
    }

    private var detailsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            detailRow("Відправлення", voyage.departureDate.formatted(date: .complete, time: .shortened))
            detailRow("Прибуття", voyage.arrivalDate.formatted(date: .complete, time: .shortened))
            if !voyage.createdBy.isEmpty {
                detailRow("Створив", voyage.createdBy)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.04), radius: 8, y: 2)
        .padding(.horizontal)
    }

    private func infoCard(icon: String, title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: icon)
                .foregroundStyle(.blue)
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.headline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.04), radius: 6, y: 2)
    }

    private func detailRow(_ label: String, _ value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.body)
        }
    }

    private var statusColor: Color {
        switch voyage.status {
        case .Queued: return .orange
        case .InProgress: return .blue
        case .Shipped: return .purple
        case .Done: return .green
        }
    }

    private func shortId(_ value: String) -> String {
        value.isEmpty ? "—" : String(value.prefix(8))
    }

    private func coordinate(for portName: String) -> CLLocationCoordinate2D {
        let known: [String: CLLocationCoordinate2D] = [
            "Одеса": CLLocationCoordinate2D(latitude: 46.49, longitude: 30.74),
            "Odessa": CLLocationCoordinate2D(latitude: 46.49, longitude: 30.74),
            "Київ": CLLocationCoordinate2D(latitude: 50.45, longitude: 30.52),
            "Стамбул": CLLocationCoordinate2D(latitude: 41.01, longitude: 28.97),
            "Istanbul": CLLocationCoordinate2D(latitude: 41.01, longitude: 28.97),
            "Анталія": CLLocationCoordinate2D(latitude: 36.88, longitude: 30.70),
            "Варна": CLLocationCoordinate2D(latitude: 43.20, longitude: 27.91),
            "Пірей": CLLocationCoordinate2D(latitude: 37.94, longitude: 23.64),
            "New-York": CLLocationCoordinate2D(latitude: 40.67, longitude: -74.08)
        ]

        if let match = known.first(where: { portName.localizedCaseInsensitiveContains($0.key) })?.value {
            return match
        }
        return region.center
    }

    private func centerMapOnRoute() {
        let from = coordinate(for: voyage.fromPort)
        let to = coordinate(for: voyage.toPort)
        let center = CLLocationCoordinate2D(
            latitude: (from.latitude + to.latitude) / 2,
            longitude: (from.longitude + to.longitude) / 2
        )
        let span = MKCoordinateSpan(
            latitudeDelta: max(abs(from.latitude - to.latitude) * 1.8, 2),
            longitudeDelta: max(abs(from.longitude - to.longitude) * 1.8, 2)
        )
        region = MKCoordinateRegion(center: center, span: span)
    }
}
