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
    @Published var isRegistered: Bool = false
    @Published var user: UserModel? = nil
    @Published var isLoading: Bool = false
    private var timer: Timer?
    
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
    
    func fetchUser() async throws{
        await MainActor.run { isLoading = true }
        
        do{
            let user = try await Authentication().getUserInfo(email: email)
            
            await MainActor.run {
                self.user = user
                self.isLoading = false
            }
            
        } catch {
            
            print("Sorry we are in trouble and try to fix errors")
            
            await MainActor.run {
                self.isLoading = false
            }
        }
        
    }
    
    func userCheck() async throws {
        if user?.isRegistered != false {
            try? await fetchUser()
        } else {
            print("You are not registered")
        }
    }
    
    func timerFetch() {
        Task { try await fetchUser() }
        
        timer = Timer.scheduledTimer(withTimeInterval: 300, repeats: true) { _ in
            Task{ try await self.fetchUser() }
        }
    }
    
    func stopAutoUpdate() {
            timer?.invalidate()
        }
}

struct registerVM{
    
}
