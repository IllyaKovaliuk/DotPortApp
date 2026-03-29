//
//  ShipService.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 29.03.2026.
//

import Foundation

actor FetchShips {
    
    func getShips() async throws -> [ShipModel]{
        let endpoint = "http://localhost:5678/webhook-test/ships"
        
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
            
            let result = try decoder.decode([ShipModel].self, from: data)
            return result
        } catch {
            throw ShipErrorrs.BadData
        }
    }
}



enum ShipErrorrs: Error{
    case InvalidUrl
    case Not200Code
    case BadData
}
