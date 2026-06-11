//
//  UserModel.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 17.02.2026.
//

import Foundation

enum Role: String, Codable, CaseIterable {
    case worker = "Worker"
    case user = "User"
    case captain = "Captain"
    case dispatcher = "Dispatcher"
}

struct UserModel: Identifiable, Codable {
    var id: String
    var firstName: String
    var lastName: String
    var email: String
    var role: String
    var workerId: String?
    var portId: String?
    var isRegistered: Bool

    enum CodingKeys: String, CodingKey {
        case id, email, role, name
        case firstName = "first_name"
        case lastName = "last_name"
        case workerId = "worker_id"
        case portId = "port_id"
        case isRegistered = "is_registered"
    }

    init(
        id: String,
        firstName: String = "",
        lastName: String = "",
        email: String,
        role: String,
        workerId: String? = nil,
        portId: String? = nil,
        isRegistered: Bool = true
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.role = role
        self.workerId = workerId
        self.portId = portId
        self.isRegistered = isRegistered
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? container.decode(String.self, forKey: .id))
            ?? (try? container.decode(Int.self, forKey: .id)).map(String.init)
            ?? UUID().uuidString
        email = Self.clean(try container.decodeIfPresent(String.self, forKey: .email) ?? "")
        role = Self.clean(try container.decodeIfPresent(String.self, forKey: .role) ?? "")
        workerId = try container.decodeIfPresent(String.self, forKey: .workerId)
        portId = try container.decodeIfPresent(String.self, forKey: .portId)
        isRegistered = try container.decodeIfPresent(Bool.self, forKey: .isRegistered) ?? true

        firstName = Self.clean(try container.decodeIfPresent(String.self, forKey: .firstName) ?? "")
        lastName = Self.clean(try container.decodeIfPresent(String.self, forKey: .lastName) ?? "")

        if firstName.isEmpty && lastName.isEmpty, let fullName = try container.decodeIfPresent(String.self, forKey: .name) {
            let cleanedName = Self.clean(fullName)
            if !cleanedName.isEmpty {
                let parts = cleanedName.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)
                firstName = parts.first.map(String.init) ?? cleanedName
                lastName = parts.count > 1 ? String(parts[1]) : ""
            }
        }

        if role.isEmpty { role = "Worker" }

        if firstName.isEmpty && lastName.isEmpty, !email.isEmpty {
            let localPart = email.split(separator: "@").first.map(String.init) ?? email
            let cleaned = localPart.replacingOccurrences(of: ".", with: " ").replacingOccurrences(of: "_", with: " ")
            let parts = cleaned.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)
            firstName = parts.first.map { $0.capitalized } ?? localPart.capitalized
            lastName = parts.count > 1 ? String(parts[1]).capitalized : ""
        }
    }

    static func clean(_ value: String) -> String {
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return "" }
        if trimmed.contains("{{") || trimmed.contains("}}") { return "" }
        if trimmed.lowercased().contains("$json") { return "" }
        return trimmed
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(email, forKey: .email)
        try container.encode(role, forKey: .role)
        try container.encodeIfPresent(workerId, forKey: .workerId)
        try container.encodeIfPresent(portId, forKey: .portId)
        try container.encode(isRegistered, forKey: .isRegistered)
    }

    var displayName: String {
        let full = "\(firstName) \(lastName)".trimmingCharacters(in: .whitespaces)
        if !full.isEmpty { return full }
        if !email.isEmpty { return email }
        return "Guest"
    }

    var safeRole: String {
        role.isEmpty ? "Worker" : role
    }

    func normalized() -> UserModel {
        var user = self
        user.firstName = Self.clean(firstName)
        user.lastName = Self.clean(lastName)
        user.email = Self.clean(email)
        user.role = Self.clean(role).isEmpty ? "Worker" : Self.clean(role)

        if user.firstName.isEmpty && user.lastName.isEmpty, !user.email.isEmpty {
            let localPart = user.email.split(separator: "@").first.map(String.init) ?? user.email
            let cleaned = localPart.replacingOccurrences(of: ".", with: " ").replacingOccurrences(of: "_", with: " ")
            let parts = cleaned.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)
            user.firstName = parts.first.map { $0.capitalized } ?? localPart.capitalized
            user.lastName = parts.count > 1 ? String(parts[1]).capitalized : ""
        }

        return user
    }

    var initials: String {
        let parts = [firstName, lastName].filter { !$0.isEmpty }
        if !parts.isEmpty {
            return parts.map { String($0.prefix(1)).uppercased() }.joined()
        }
        if !email.isEmpty {
            return String(email.prefix(2)).uppercased()
        }
        return "G"
    }
}

struct LoginRequest: Codable {
    let email: String
    let password: String
}

struct RegisterRequest: Codable {
    let email: String
    let password: String
    let role: String
    let workerId: String?
    let portId: String?

    enum CodingKeys: String, CodingKey {
        case email, password, role
        case workerId = "worker_id"
        case portId = "port_id"
    }
}

struct AuthResponse: Codable {
    let user: UserModel
    let token: String?
}
