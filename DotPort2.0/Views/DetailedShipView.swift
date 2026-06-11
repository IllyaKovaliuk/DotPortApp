//
//  DetailedShipView.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 23.02.2026.
//

import SwiftUI

struct DetailedShipView: View {
    let shipId: String
    @StateObject var viewModel = ShipsViewModel()

    var body: some View {
        Group {
            if viewModel.isLoading2 && viewModel.ship == nil {
                ProgressView("Loading ship...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let ship = viewModel.ship {
                DetailedShipCard(ship: ship)
            } else {
                ContentUnavailableView("Ship not found", systemImage: "ferry", description: Text("Try again later"))
            }
        }
        .background(Color(red: 0.98, green: 0.98, blue: 0.96))
        .navigationTitle("Ship Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { viewModel.timerFetchId(id: shipId) }
        .onDisappear { viewModel.stopAutoUpdate() }
    }
}

struct DetailedShipCard: View {
    let ship: ShipModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                shipImageSection
                shipHeaderSection
                specsGridSection
                statusSection
            }
            .padding()
        }
    }

    private var shipImageSection: some View {
        AsyncImage(url: URL(string: ship.imageName ?? "")) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            ZStack {
                Color.gray.opacity(0.12)
                Image(systemName: "ferry.fill")
                    .font(.system(size: 48))
                    .foregroundStyle(.secondary)
            }
        }
        .frame(height: 220)
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }

    private var shipHeaderSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(ship.name)
                .font(.system(size: 32, weight: .bold, design: .rounded))

            Text("ID: \(ship.id)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white)
        .cornerRadius(16)
    }

    private var specsGridSection: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            specCard(title: "Type", value: ship.shipType!.rawValue)
            specCard(title: "Engine", value: ship.engineType?.rawValue ?? "—")
            specCard(title: "Capacity (T)", value: ship.capacityWeight.map { String(format: "%.0f", $0) } ?? "—")
            specCard(title: "Containers", value: ship.capacityContainers.map(String.init) ?? "—")
            specCard(title: "Current load", value: ship.currentLoad.map(String.init) ?? "—")
            specCard(title: "Est. power", value: String(format: "%.0f kW", ship.estimatedPower))
        }
    }

    private var statusSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Operational Status")
                .font(.headline)

            HStack {
                Circle()
                    .fill(statusColor)
                    .frame(width: 10, height: 10)
                Text(ship.status?.rawValue ?? "Unknown")
                    .font(.subheadline.weight(.semibold))
                Spacer()
            }

            if let portId = ship.currentPortId, !portId.isEmpty {
                detailLine("Current port", portId)
            }
            if let portId = ship.portId, !portId.isEmpty {
                detailLine("Home port", portId)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
    }

    private func specCard(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title.uppercased())
                .font(.caption2)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.headline)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white)
        .cornerRadius(14)
    }

    private func detailLine(_ label: String, _ value: String) -> some View {
        HStack {
            Text(label)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.medium)
        }
        .font(.subheadline)
    }

    private var statusColor: Color {
        switch ship.status {
        case .Inprogress: return .blue
        case .Shipped: return .green
        case .Notstarted: return .orange
        case .none: return .gray
        }
    }
}

#Preview {
    NavigationStack {
        DetailedShipView(shipId: "")
    }
}
