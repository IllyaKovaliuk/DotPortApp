//
//  loginModel.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 17.02.2026.
//

import Foundation

struct loginModel{
    let email: String
    var password: String
}

enum userType{
    case worker;
    case user;
}

struct registerModel{
    let email: String
    let password: String
    var workId: Int
    var portId: Int
    var userCategory: userType
}
