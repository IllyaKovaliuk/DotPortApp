//
//  GetRequests.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 26.03.2026.
//

import Foundation

actor GetVoyages {

    func getVoyages() async throws -> [VoyageItem] {
        let endpoint = "http://localhost:5678/webhook/voyages"

        guard let url = URL(string: endpoint) else {
            throw NetErrorrs.InvalidUrl
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetErrorrs.Not200Code
        }

        if data.isEmpty {
            return DemoData.voyages
        }

        do {
            let decoder = ApiJSONDecoder.make()
            let dtos: [VoyageDTO]
            if let direct = try? decoder.decode([VoyageDTO].self, from: data) {
                dtos = direct
            } else {
                dtos = try ApiJSONDecoder.decodeList(VoyageDTO.self, from: data)
            }
            if dtos.isEmpty {
                return DemoData.voyages
            }
            return dtos.map { VoyageItem(from: $0) }
        } catch {
            return DemoData.voyages
        }
    }

    func getVoyage(id: String) {
        _ = id
    }

    func postVoyage(newVoyage: VoyageDTO) async throws {
        let endpoint = "http://localhost:5678/webhook/3ee1aaa6-8392-44fa-a8d1-bdcbc3a74552"

        guard let url = URL(string: endpoint) else {
            throw NetErrorrs.InvalidUrl
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601

        let jsonData = try encoder.encode(newVoyage)
        request.httpBody = jsonData

        let (_, response) = try await URLSession.shared.data(for: request)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetErrorrs.BadData
        }
    }
}

enum NetErrorrs: Error {
    case InvalidUrl
    case Not200Code
    case BadData
}
