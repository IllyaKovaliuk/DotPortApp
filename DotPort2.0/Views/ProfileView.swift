//
//  ProfileView.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 19.02.2026.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var auth: AuthManager
    @StateObject private var portVm = PortsViewModel()

    private var userId: String {
        auth.currentUser?.id ?? "—"
    }

    private var portLabel: String {
        guard let portId = auth.currentUser?.portId, !portId.isEmpty else {
            return "Not assigned"
        }
        if let port = portVm.ports.first(where: { $0.id == portId }) {
            return "\(port.name) (\(port.code))"
        }
        return portId
    }

    var body: some View {
        ZStack {
            Color(red: 0.98, green: 0.98, blue: 0.96)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 25) {
                    VStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(Color(red: 43/255, green: 50/255, blue: 63/255))
                                .frame(width: 120, height: 120)

                            Text(auth.currentUser?.initials ?? "U")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)

                        VStack(spacing: 4) {
                            Text(auth.currentUser?.displayName ?? "Guest")
                                .font(.title2).bold()
                            Text(auth.currentUser?.safeRole ?? "Worker")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.top, 20)

                    VStack(spacing: 12) {
                        ProfileInfoRow(title: "User ID", value: userId, icon: "number")
                        ProfileInfoRow(title: "Port", value: portLabel, icon: "mappin.and.ellipse")
                    }
                    .padding(.horizontal)

                    Button(action: {
                        auth.logout()
                    }) {
                        Text("Log Out")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(15)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 100)
                }
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { portVm.timerFetch() }
        .onDisappear { portVm.stopAutoUpdate() }
    }
}

struct ProfileInfoRow: View {
    let title: String
    let value: String
    let icon: String

    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .foregroundColor(.white)
                .frame(width: 36, height: 36)
                .background(Color(red: 43/255, green: 50/255, blue: 63/255))
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.headline)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
            }

            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.03), radius: 5)
    }
}

#Preview {
    NavigationStack {
        ProfileView()
            .environmentObject(AuthManager())
    }
}
