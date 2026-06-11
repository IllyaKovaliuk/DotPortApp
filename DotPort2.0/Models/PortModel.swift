//
//  PortModel.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 17.02.2026.
//

import Foundation
import MapKit
import SwiftData

enum BerthStatus: String, Codable {
    case opened = "Open"
    case closed = "Closed"
    case NotAvailableNow = "NotAvailableNow"
}

struct PortModel: Identifiable, Equatable, Codable, Hashable {
    var id: String
    var name: String
    var country: String
    var code: String
    var latitude: Double
    var longtitude: Double?
    var isActive: Bool
    var createdAt: Date
    var updatedAt: Date
    var berthStatus: BerthStatus
    var shipsCount: Int
    var berthCount: Int
    var description: String?

    enum CodingKeys: String, CodingKey {
        case id, name, country, code, latitude, longtitude, longitude, description
        case isActive = "is_active"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case berthStatus = "berth_status"
        case shipsCount = "ships_count"
        case berthCount = "berth_count"
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        id = try c.decode(String.self, forKey: .id)
        name = try c.decodeIfPresent(String.self, forKey: .name) ?? ""
        country = try c.decodeIfPresent(String.self, forKey: .country) ?? ""
        code = try c.decodeIfPresent(String.self, forKey: .code) ?? ""
        latitude = try c.decodeIfPresent(Double.self, forKey: .latitude) ?? 0
        let lngTypo = try c.decodeIfPresent(Double.self, forKey: .longtitude)
        let lngDb = try c.decodeIfPresent(Double.self, forKey: .longitude)
        longtitude = lngTypo ?? lngDb
        isActive = try c.decodeIfPresent(Bool.self, forKey: .isActive) ?? true
        createdAt = try c.decodeIfPresent(Date.self, forKey: .createdAt) ?? Date()
        updatedAt = try c.decodeIfPresent(Date.self, forKey: .updatedAt) ?? Date()
        berthStatus = try Self.decodeBerthStatus(from: c)
        shipsCount = try c.decodeIfPresent(Int.self, forKey: .shipsCount) ?? 0
        berthCount = try c.decodeIfPresent(Int.self, forKey: .berthCount) ?? 0
        description = try c.decodeIfPresent(String.self, forKey: .description)
    }

    private static func decodeBerthStatus(from c: KeyedDecodingContainer<CodingKeys>) throws -> BerthStatus {
        guard let raw = try c.decodeIfPresent(String.self, forKey: .berthStatus) else {
            return .opened
        }
        return BerthStatus(rawValue: raw) ?? .opened
    }

    func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encode(id, forKey: .id)
        try c.encode(name, forKey: .name)
        try c.encode(country, forKey: .country)
        try c.encode(code, forKey: .code)
        try c.encode(latitude, forKey: .latitude)
        try c.encodeIfPresent(longtitude, forKey: .longtitude)
        try c.encodeIfPresent(longtitude, forKey: .longitude)
        try c.encode(isActive, forKey: .isActive)
        try c.encode(createdAt, forKey: .createdAt)
        try c.encode(updatedAt, forKey: .updatedAt)
        try c.encode(berthStatus, forKey: .berthStatus)
        try c.encode(shipsCount, forKey: .shipsCount)
        try c.encode(berthCount, forKey: .berthCount)
        try c.encodeIfPresent(description, forKey: .description)
    }

    init(
        id: String,
        name: String,
        country: String,
        code: String,
        latitude: Double = 0,
        longtitude: Double? = nil,
        isActive: Bool = true,
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        berthStatus: BerthStatus = .opened,
        shipsCount: Int = 0,
        berthCount: Int = 0,
        description: String? = nil
    ) {
        self.id = id
        self.name = name
        self.country = country
        self.code = code
        self.latitude = latitude
        self.longtitude = longtitude
        self.isActive = isActive
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.berthStatus = berthStatus
        self.shipsCount = shipsCount
        self.berthCount = berthCount
        self.description = description
    }

    var coordinate: CLLocationCoordinate2D {
        validCoordinate
    }

    var validCoordinate: CLLocationCoordinate2D {
        var lat = latitude
        var lng = longtitude ?? 0

        if lat.isNaN || lng.isNaN || lat.isInfinite || lng.isInfinite {
            return CLLocationCoordinate2D(latitude: 50.45, longitude: 30.52)
        }

        if abs(lat) > 90, abs(lng) <= 90 {
            swap(&lat, &lng)
        }

        lat = min(90, max(-90, lat))
        lng = min(180, max(-180, lng))

        if lat == 0, lng == 0 {
            return CLLocationCoordinate2D(latitude: 50.45, longitude: 30.52)
        }

        return CLLocationCoordinate2D(latitude: lat, longitude: lng)
    }

    static func safeMapRegion(for port: PortModel) -> MKCoordinateRegion {
        MKCoordinateRegion(
            center: port.validCoordinate,
            span: MKCoordinateSpan(latitudeDelta: 1.5, longitudeDelta: 1.5)
        )
    }
}

struct PortStats {
    let totalBerths: Int
    let availableBerths: Int
    let inQueue: Int
    let activeVoyages: Int
    let shipsAtPort: Int
}

enum PortStatsCalculator {

    static func stats(for port: PortModel, voyages: [VoyageItem], ships: [ShipModel]) -> PortStats {
        let related = voyages.filter { voyageMatchesPort($0, port: port) }
        let activeVoyages = related.filter { $0.status == .InProgress }.count
        let inQueue = related.filter { $0.status == .Queued }.count
        let shipsAtPort = ships.filter { shipAtPort($0, port: port) }.count
        let shipsInProgress = ships.filter { shipAtPort($0, port: port) && $0.status == .Inprogress }.count

        let totalBerths = max(port.berthCount, 0)
        let occupied = max(activeVoyages, shipsInProgress)
        let available: Int = switch port.berthStatus {
        case .opened:
            max(0, totalBerths - occupied)
        case .closed, .NotAvailableNow:
            0
        }

        return PortStats(
            totalBerths: totalBerths,
            availableBerths: available,
            inQueue: inQueue,
            activeVoyages: activeVoyages,
            shipsAtPort: shipsAtPort
        )
    }

    static func activeVoyages(for port: PortModel, from voyages: [VoyageItem]) -> [VoyageItem] {
        voyages
            .filter { voyageMatchesPort($0, port: port) && ($0.status == .InProgress || $0.status == .Queued) }
            .sorted { $0.departureDate < $1.departureDate }
    }

    static func voyageMatchesPort(_ voyage: VoyageItem, port: PortModel) -> Bool {
        if !voyage.portId.isEmpty, voyage.portId == port.id { return true }

        let name = port.name.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        let code = port.code.lowercased()
        let from = voyage.fromPort.lowercased()
        let to = voyage.toPort.lowercased()

        if name.isEmpty { return false }
        if from == name || to == name { return true }
        if from.contains(name) || to.contains(name) { return true }
        if !code.isEmpty, (from.contains(code) || to.contains(code)) { return true }
        return false
    }

    static func shipAtPort(_ ship: ShipModel, port: PortModel) -> Bool {
        ship.portId == port.id || ship.currentPortId == port.id
    }
}
