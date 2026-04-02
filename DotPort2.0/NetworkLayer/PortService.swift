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
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("RAW JSON FROM n8n: \(jsonString)")
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw PortErrorrs.Not200Code
        }
        
        do {
            let decoder = JSONDecoder()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            decoder.dateDecodingStrategy = .formatted(formatter)
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let dtos = try decoder.decode([PortModel].self, from: data)
            
            return dtos
        } catch {
            throw PortErrorrs.BadData
        }
        
    }
    
    func getPort(portId: String) async throws -> PortModel {
        let endpoint = "http://localhost:5678/webhook/get-port?id=\(portId)"
        
        guard let url = URL(string: endpoint) else { throw PortErrorrs.InvalidUrl}
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("RAW JSON FROM n8n: \(jsonString)")
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw PortErrorrs.Not200Code
        }
        
        do {
            let decoder = JSONDecoder()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            decoder.dateDecodingStrategy = .formatted(formatter)
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let result = try decoder.decode([PortModel].self, from: data)
            
            guard let firstPort = result.first else {
                throw PortErrorrs.BadData
            }
            return firstPort
            
        } catch let decodingError as DecodingError {
            // ЦЕ НАЙВАЖЛИВІШЕ: воно напише, яке поле не розпарсилось
            print("❌ ПОМИЛКА ДЕКОДУВАННЯ: \(decodingError)")
            throw PortErrorrs.BadData
        } catch {
            print("❌ НЕВІДОМА ПОМИЛКА: \(error)")
            throw error
        }
        
    }
}

enum PortErrorrs: Error{
    case InvalidUrl
    case Not200Code
    case BadData
}
