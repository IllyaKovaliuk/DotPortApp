//
//  loginViewModel.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 17.02.2026.
//

import Foundation

@MainActor
class loginVM: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    @Published var isRegistered: Bool = false
    @Published var user: UserModel? = nil
    @Published var isLoading: Bool = false

    var isValid: Bool {
        !email.isEmpty && email.contains("@") && password.count >= 6
    }

    func loginUser() async {
        guard isValid else {
            errorMessage = "Перевір email і пароль (мін. 6 символів)"
            showError = true
            return
        }

        isLoading = true
        showError = false
        errorMessage = ""

        do {
            let response = try await AuthService().login(email: email, password: password)
            user = response.user
            isRegistered = response.user.isRegistered
        } catch {
            errorMessage = "Невірний email або пароль"
            showError = true
            print("❌ loginVM error:", error)
        }

        isLoading = false
    }

    func registerUser(role: String, workerId: String = "", portId: String = "") async {
        guard isValid else {
            errorMessage = "Перевір email і пароль (мін. 6 символів)"
            showError = true
            return
        }

        isLoading = true
        showError = false
        errorMessage = ""

        do {
            let response = try await AuthService().register(
                email: email,
                password: password,
                role: role,
                workerId: workerId.isEmpty ? nil : workerId,
                portId: portId.isEmpty ? nil : portId
            )
            user = response.user
            isRegistered = response.user.isRegistered
        } catch {
            errorMessage = "Не вдалося зареєструватись"
            showError = true
            print("❌ registerVM error:", error)
        }

        isLoading = false
    }
}
