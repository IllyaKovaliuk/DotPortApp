//
//  authManager.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 04.05.2026.
//

import Foundation

@MainActor
final class AuthManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: UserModel?
    @Published var errorMessage = ""
    @Published var isLoading = false

    private let tokenKey = "dotport_auth_token"
    private let userKey = "dotport_auth_user"

    init() {
        restoreSession()
    }

    func login(email: String, password: String) async {
        guard !email.isEmpty, email.contains("@"), password.count >= 6 else {
            errorMessage = "Перевір email і пароль (мін. 6 символів)"
            return
        }

        isLoading = true
        errorMessage = ""

        do {
            let response = try await AuthService().login(email: email, password: password)
            applySuccess(response, fallbackEmail: email)
        } catch {
            errorMessage = "Невірний email або пароль"
            print("❌ login error:", error)
        }

        isLoading = false
    }

    func register(email: String, password: String, role: String, workerId: String, portId: String) async {
        guard !email.isEmpty, email.contains("@"), password.count >= 6 else {
            errorMessage = "Перевір email і пароль (мін. 6 символів)"
            return
        }

        isLoading = true
        errorMessage = ""

        do {
            let response = try await AuthService().register(
                email: email,
                password: password,
                role: role,
                workerId: workerId.isEmpty ? nil : workerId,
                portId: portId.isEmpty ? nil : portId
            )
            applySuccess(response, fallbackEmail: email)
        } catch {
            errorMessage = "Не вдалося зареєструватись"
            print("❌ register error:", error)
        }

        isLoading = false
    }

    func logout() {
        currentUser = nil
        isAuthenticated = false
        UserDefaults.standard.removeObject(forKey: tokenKey)
        UserDefaults.standard.removeObject(forKey: userKey)
    }

    private func applySuccess(_ response: AuthResponse, fallbackEmail: String? = nil) {
        var user = response.user.normalized()

        if user.email.isEmpty, let fallbackEmail, !fallbackEmail.isEmpty {
            user.email = fallbackEmail.trimmingCharacters(in: .whitespacesAndNewlines)
            user = user.normalized()
        }

        currentUser = user
        isAuthenticated = true
        saveSession(user: user, token: response.token)
    }

    private func saveSession(user: UserModel, token: String?) {
        if let token {
            UserDefaults.standard.set(token, forKey: tokenKey)
        }
        if let data = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(data, forKey: userKey)
        }
    }

    private func restoreSession() {
        guard let data = UserDefaults.standard.data(forKey: userKey),
              let user = try? JSONDecoder().decode(UserModel.self, from: data) else {
            return
        }
        let normalized = user.normalized()
        currentUser = normalized
        isAuthenticated = true
        saveSession(user: normalized, token: UserDefaults.standard.string(forKey: tokenKey))
    }
}
