//
//  UserService.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 29.03.2026.
//

import Foundation


actor FetchUsers {
    
    func getUsers() async throws -> [UserModel]{
        let endpoint = "http://localhost:5678/webhook-test/users"
        
        guard let url = URL(string: endpoint) else {
            throw UserErrorrs.InvalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw UserErrorrs.Not200Code
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode([UserModel].self, from: data)
            return result
        } catch {
            throw UserErrorrs.BadData
        }
        
    }
    
}

enum UserErrorrs: Error{
    case InvalidUrl
    case Not200Code
    case BadData
}
