//
//  ShipService.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 29.03.2026.
//

import Foundation

actor FetchShips {
    
    func getShips() async throws -> [ShipModel]{
        let endpoint = "http://localhost:5678/webhook/ships"
        
        guard let url = URL(string: endpoint) else {
            throw ShipErrorrs.InvalidUrl
        }
        
        
        let (data, response) = try await URLSession.shared.data(from: url)
            
        if let jsonString = String(data: data, encoding: .utf8){
            print("This is out json, \(jsonString)")
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ShipErrorrs.Not200Code
        }
        
        do{
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
            
            let result = try decoder.decode([ShipModel].self, from: data)
            return result
        } catch let decodingError as DecodingError {
            // ЦЕ НАЙВАЖЛИВІШЕ: воно напише, яке поле не розпарсилось
            print("❌ ПОМИЛКА ДЕКОДУВАННЯ: \(decodingError)")
            throw ShipErrorrs.BadData
        } catch {
            print("❌ НЕВІДОМА ПОМИЛКА: \(error)")
            throw error
        }
    }
    
    func getShipId(shipId: String ) async throws -> ShipModel {
        
        let endpoint = "http://localhost:5678/webhook/get-ship?id=\(shipId)"
        
        print("🌐 SHIP URL: \(endpoint)")
        
        guard let url = URL(string: endpoint) else {
            throw ShipErrorrs.InvalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as?  HTTPURLResponse, response.statusCode == 200 else {
            throw ShipErrorrs.Not200Code
        }
        
        if let raw = String(data: data, encoding: .utf8) {
               print("📦 RAW SHIP JSON: \(raw)")
           }
        
        do {
            let decoder = JSONDecoder()
            
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
            
            let result = try decoder.decode([ShipModel].self, from: data)
            
            guard let firstShip = result.first else {
                throw ShipErrorrs.BadData
            }
            return firstShip
            
        } catch let decodingError as DecodingError {
            // ЦЕ НАЙВАЖЛИВІШЕ: воно напише, яке поле не розпарсилось
            print("❌ ПОМИЛКА ДЕКОДУВАННЯ: \(decodingError)")
            throw ShipErrorrs.BadData
        } catch {
            print("❌ НЕВІДОМА ПОМИЛКА: \(error)")
            throw error
        }
    }
}



enum ShipErrorrs: Error{
    case InvalidUrl
    case Not200Code
    case BadData
}
