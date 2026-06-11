//
//  ShipService.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 29.03.2026.
//

import Foundation

actor FetchShips {

    func getShips() async throws -> [ShipModel] {
        let endpoint = "http://localhost:5678/webhook/ships"

        guard let url = URL(string: endpoint) else {
            throw ShipErrorrs.InvalidUrl
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ShipErrorrs.Not200Code
        }

        if data.isEmpty {
            return DemoData.ships
        }

        do {
            let ships = try ApiJSONDecoder.decodeList(ShipModel.self, from: data)
            if ships.isEmpty {
                return DemoData.ships
            }
            return ships
        } catch {
            return DemoData.ships
        }
    }

    func getShipId(shipId: String) async throws -> ShipModel {
        let endpoint = "http://localhost:5678/webhook/get-ship?id=\(shipId)"

        guard let url = URL(string: endpoint) else {
            throw ShipErrorrs.InvalidUrl
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ShipErrorrs.Not200Code
        }

        if data.isEmpty, let demo = DemoData.ship(id: shipId) {
            return demo
        }

        do {
            let ships = try ApiJSONDecoder.decodeList(ShipModel.self, from: data)
            if let firstShip = ships.first { return firstShip }
            if let demo = DemoData.ship(id: shipId) { return demo }
            throw ShipErrorrs.BadData
        } catch {
            if let demo = DemoData.ship(id: shipId) { return demo }
            throw ShipErrorrs.BadData
        }
    }
}

enum ShipErrorrs: Error {
    case InvalidUrl
    case Not200Code
    case BadData
}
