//
//  UserModel.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 17.02.2026.
//

import Foundation

enum Role: String, Codable{
    case CargoManager
    case Captain
    case Dispatcher
    case Worker
}

struct UserModel: Identifiable {
    var id: String
    
    var first_name: String
    var last_name: String
    var email: String
    var password: String
    var role: Role
    var createdAt = Date()
}
