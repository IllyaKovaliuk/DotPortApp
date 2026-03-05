//
//  loginViewModel.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 17.02.2026.
//

import Foundation


class loginVM: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    
    var isValid : Bool {
        !email.isEmpty && email.contains("@") && password.count >= 6
    }
    
    func loginUser(){
        if !isValid {
            errorMessage = "Please something wrong in your email or password"
            showError = true
            return
        }
        
        print("Login in with \(email)")
        
    }
    
}

struct registerVM{
    
}
