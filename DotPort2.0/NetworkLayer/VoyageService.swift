//
//  GetRequests.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 26.03.2026.
//

import Foundation


actor GetVoyages{
    
    func getVoyages() async throws -> [Voyage] {
        let endpoint = "http://localhost:5678/webhook/voyages"
        
        guard let url = URL(string: endpoint) else {
            throw NetErrorrs.InvalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("RAW JSON FROM n8n: \(jsonString)")
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetErrorrs.Not200Code
        }
        
        do {
            let decoder = JSONDecoder()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            decoder.dateDecodingStrategy = .formatted(formatter)
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let dtos = try decoder.decode([VoyageDTO].self, from: data)
            
            return dtos.map {Voyage(from: $0)}
        } catch {
            throw NetErrorrs.BadData
        }
    }
        
    func getVoyage(id: String){
        print(id)
    }
    
    func postVoyage(newVoyage: VoyageDTO) async throws {
        
        let endpoint = "http://localhost:5678/webhook/3ee1aaa6-8392-44fa-a8d1-bdcbc3a74552"
        
        guard let url = URL(string: endpoint) else{
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
        
        print("Success")
    }
    
}

enum NetErrorrs: Error{
    case InvalidUrl
    case Not200Code
    case BadData
}

