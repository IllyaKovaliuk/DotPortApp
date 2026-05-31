//
//  ProfileView.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 19.02.2026.
//

import SwiftUI
//import LinkedListPackage

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.98, green: 0.98, blue: 0.96)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        
                        // MARK: - Header (Аватар та ім'я)
                        VStack(spacing: 12) {
                            ZStack {
                                Circle()
                                    .fill(Color(red: 43/255, green: 50/255, blue: 63/255))
                                    .frame(width: 120, height: 120)
                                
                                Text("IK")
                                    .font(.system(size: 40, weight: .bold))
                                    .foregroundColor(.white)
                            }
                            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                            
                            VStack(spacing: 4) {
                                Text("Illya Kovaliuk")
                                    .font(.title2).bold()
                                Text("Senior Logistics Manager")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.top, 20)
                        
                        // MARK: - Statistics Row
                        HStack(spacing: 20) {
                            ProfileStatItem(title: "Voyages", value: "1,247")
                            ProfileStatItem(title: "Efficiency", value: "98%")
                            ProfileStatItem(title: "Experience", value: "12y")
                        }
                        .padding(.horizontal)
                        
                        // MARK: - Settings Sections
                        VStack(spacing: 20) {
                            ProfileSection(title: "Account Settings") {
                                ProfileRow(icon: "person.fill", title: "Personal Info", color: .blue)
                                ProfileRow(icon: "shield.fill", title: "Security", color: .green)
                                ProfileRow(icon: "bell.fill", title: "Notifications", color: .red)
                            }
                            
                            ProfileSection(title: "Logistics Data") {
                                ProfileRow(icon: "ferry.fill", title: "My Fleet", color: .orange)
                                ProfileRow(icon: "doc.text.fill", title: "Reports Archive", color: .purple)
                            }
                        }
                        .padding(.horizontal)
                        
                        // MARK: - Logout Button
                        Button(action: {
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
        }
    }
}

// MARK: - Supporting Views

struct ProfileStatItem: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 5) {
            Text(value)
                .font(.headline).bold()
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 15)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.03), radius: 5)
    }
}

struct ProfileSection<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.caption).bold()
                .foregroundColor(.secondary)
                .padding(.leading, 5)
            
            VStack(spacing: 0) {
                content
            }
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.03), radius: 5)
        }
    }
}

struct ProfileRow: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        Button(action: {}) {
            HStack(spacing: 15) {
                Image(systemName: icon)
                    .foregroundColor(.white)
                    .frame(width: 32, height: 32)
                    .background(color)
                    .cornerRadius(8)
                
                Text(title)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption).bold()
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        Divider().padding(.leading, 60)
    }
}

#Preview {
    ProfileView()
}
