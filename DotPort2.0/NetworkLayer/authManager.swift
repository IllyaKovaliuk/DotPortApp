//
//  authManager.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 04.05.2026.
//
import Foundation

class AuthManager: ObservableObject {
    @Published var isAuthenticated: Bool = false
    
    init(){}
    
    func login(){
        
        isAuthenticated = true
    }
    
    func logOut(){
        isAuthenticated = false
    }
}
