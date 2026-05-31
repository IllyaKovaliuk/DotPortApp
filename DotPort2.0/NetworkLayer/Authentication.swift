//
//  Authentication.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 04.05.2026.
//

import Foundation

actor Authentication {
    
    func getUserInfo(email: String) async throws -> UserModel {
        let path = "http://localhost:5678/webhook/get-user"
        
        guard let url = URL(string: path) else {
            throw UserErrorrs.InvalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw UserErrorrs.Not200Code
        }
        
        do {
            let decoder = JSONDecoder()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .formatted(formatter)
            
            let dtos = try decoder.decode(UserModel.self, from: data)
            
            return dtos
        } catch {
            throw UserErrorrs.BadData
        }
        
    }
    
    
    func postUserInfo() async throws {
        let path = "http://localhost:5678/webhook/ec3d140e-d996-4dad-adba-94745bf70009"
        
        guard let url = URL(string: path) else {
            throw UsersErrorrs.BadUrl
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        
    }
    
}


enum UsersErrorrs: Error {
    case BadUrl
    case Not200Code
    case BadData
}
