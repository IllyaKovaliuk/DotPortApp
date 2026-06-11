//
//  Authentication.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 04.05.2026.
//

import Foundation

actor AuthService {
    private let loginURL = "http://localhost:5678/webhook/auth-login"
    private let registerURL = "http://localhost:5678/webhook/auth-register"

    func login(email: String, password: String) async throws -> AuthResponse {
        try await postAuth(url: loginURL, body: LoginRequest(email: email, password: password))
    }

    func register(email: String, password: String, role: String, workerId: String?, portId: String?) async throws -> AuthResponse {
        try await postAuth(
            url: registerURL,
            body: RegisterRequest(email: email, password: password, role: role, workerId: workerId, portId: portId)
        )
    }

    private func postAuth<T: Encodable>(url: String, body: T) async throws -> AuthResponse {
        guard let endpoint = URL(string: url) else {
            throw AuthError.invalidUrl
        }

        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(body)

        let (data, response) = try await URLSession.shared.data(for: request)

        if let raw = String(data: data, encoding: .utf8) {
            print("AUTH RAW:", raw)
        }

        guard let http = response as? HTTPURLResponse else {
            throw AuthError.badResponse
        }

        guard http.statusCode == 200 else {
            throw AuthError.http(http.statusCode)
        }

        let decoder = ApiJSONDecoder.make()

        if let auth = try? decoder.decode(AuthResponse.self, from: data) {
            return auth
        }

        let user = try decoder.decode(UserModel.self, from: data)
        return AuthResponse(user: user, token: nil)
    }
}

enum AuthError: LocalizedError {
    case invalidUrl
    case badResponse
    case http(Int)
    case invalidCredentials

    var errorDescription: String? {
        switch self {
        case .invalidUrl: return "Невірний URL авторизації"
        case .badResponse: return "Помилка відповіді сервера"
        case .http(let code): return "Помилка сервера: \(code)"
        case .invalidCredentials: return "Невірний email або пароль"
        }
    }
}
