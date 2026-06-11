//
//  PortService.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 27.03.2026.
//

import Foundation

actor FetchPorts {

    func getPorts() async throws -> [PortModel] {
        let endpoint = "http://localhost:5678/webhook/ports"

        guard let url = URL(string: endpoint) else {
            throw PortErrorrs.InvalidUrl
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw PortErrorrs.Not200Code
        }

        if data.isEmpty {
            return DemoData.ports
        }

        do {
            let ports = try ApiJSONDecoder.decodeList(PortModel.self, from: data)
            if ports.isEmpty {
                return DemoData.ports
            }
            return ports
        } catch {
            return DemoData.ports
        }
    }

    func getPort(portId: String) async throws -> PortModel {
        let endpoint = "http://localhost:5678/webhook/get-port?id=\(portId)"

        guard let url = URL(string: endpoint) else { throw PortErrorrs.InvalidUrl }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw PortErrorrs.Not200Code
        }

        if data.isEmpty, let demo = DemoData.port(id: portId) {
            return demo
        }

        do {
            let ports = try ApiJSONDecoder.decodeList(PortModel.self, from: data)
            if let firstPort = ports.first { return firstPort }
            if let demo = DemoData.port(id: portId) { return demo }
            throw PortErrorrs.BadData
        } catch {
            if let demo = DemoData.port(id: portId) { return demo }
            throw PortErrorrs.BadData
        }
    }
}

enum PortErrorrs: Error {
    case InvalidUrl
    case Not200Code
    case BadData
}

enum ApiJSONDecoder {
    static func make() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let value = try container.decode(String.self)

            let withFraction = ISO8601DateFormatter()
            withFraction.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            if let date = withFraction.date(from: value) {
                return date
            }

            let plain = ISO8601DateFormatter()
            plain.formatOptions = [.withInternetDateTime]
            if let date = plain.date(from: value) {
                return date
            }

            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Невідомий формат дати: \(value)"
            )
        }
        return decoder
    }

    private struct ListWrapper<T: Decodable>: Decodable {
        let data: [T]
    }

    static func decodeList<T: Decodable>(_ type: T.Type, from data: Data) throws -> [T] {
        let decoder = make()

        if let items = try? decoder.decode([T].self, from: data) {
            return items
        }

        if let wrapped = try? decoder.decode(ListWrapper<T>.self, from: data) {
            return wrapped.data
        }

        throw DecodingError.dataCorrupted(
            .init(codingPath: [], debugDescription: "Expected array or { data: [] }")
        )
    }
}
