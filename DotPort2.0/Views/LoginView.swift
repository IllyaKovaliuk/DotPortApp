//
//  LoginView.swift
//  DotPort
//
//  Created by Illya Kovaliuk on 24.01.2026.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var auth: AuthManager
    @State private var email = ""
    @State private var password = ""
    @State private var showRegister = false

    var body: some View {
        VStack(spacing: 10) {
            Text("Sign in")
                .font(.largeTitle.bold())

            Text("Glad to see you again")
                .font(.title)
                .hAlign(.leading)

            VStack(spacing: 13) {
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                    .border(1, .gray.opacity(0.5))
                    .padding(.top, 25)

                SecureField("Password", text: $password)
                    .textContentType(.password)
                    .border(1, .gray.opacity(0.5))
                    .padding(.top, 25)

                if !auth.errorMessage.isEmpty {
                    Text(auth.errorMessage)
                        .font(.caption)
                        .foregroundColor(.red)
                        .hAlign(.leading)
                }

                Button {
                    Task { await auth.login(email: email, password: password) }
                } label: {
                    Text(auth.isLoading ? "Loading..." : "Sign in")
                        .foregroundColor(.white)
                        .hAlign(.center)
                        .fillView(Color(red: 43/255, green: 50/255, blue: 63/255))
                }
                .disabled(auth.isLoading)
                .padding(.top, 10)
            }

            HStack {
                Text("Do not have any account")
                    .foregroundColor(.gray)

                Button("Register Now") {
                    showRegister.toggle()
                }
                .fontWeight(.bold)
                .foregroundColor(.black)
            }
            .font(.callout)
            .vAlign(.bottom)
            .fullScreenCover(isPresented: $showRegister) {
                RegisterView()
                    .environmentObject(auth)
            }
        }
        .vAlign(.top)
        .padding(15)
    }
}

struct RegisterView: View {
    @EnvironmentObject private var auth: AuthManager
    @Environment(\.dismiss) private var dismiss

    @State private var email = ""
    @State private var password = ""
    @State private var workerID = ""
    @State private var portID = ""
    @State private var groupUser = "Worker"
    let groups = ["Worker", "User"]

    var body: some View {
        VStack(spacing: 10) {
            Text("Register in")
                .font(.largeTitle.bold())

            VStack(spacing: 13) {
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                    .border(1, .gray.opacity(0.5))
                    .padding(.top, 25)

                SecureField("Password", text: $password)
                    .textContentType(.newPassword)
                    .border(1, .gray.opacity(0.5))
                    .padding(.top, 25)

                TextField("Work id", text: $workerID)
                    .border(1, .gray.opacity(0.5))
                    .padding(.top, 25)

                TextField("Port id", text: $portID)
                    .border(1, .gray.opacity(0.5))
                    .padding(.top, 25)

                Picker("Role", selection: $groupUser) {
                    ForEach(groups, id: \.self) { group in
                        Text(group)
                    }
                }
                .border(1, .gray.opacity(0.5))
                .padding(.top, 25)

                if !auth.errorMessage.isEmpty {
                    Text(auth.errorMessage)
                        .font(.caption)
                        .foregroundColor(.red)
                        .hAlign(.leading)
                }

                Button {
                    Task {
                        await auth.register(
                            email: email,
                            password: password,
                            role: groupUser,
                            workerId: workerID,
                            portId: portID
                        )
                        if auth.isAuthenticated {
                            dismiss()
                        }
                    }
                } label: {
                    Text(auth.isLoading ? "Loading..." : "Create account")
                        .foregroundColor(.white)
                        .hAlign(.center)
                        .fillView(Color(red: 43/255, green: 50/255, blue: 63/255))
                }
                .disabled(auth.isLoading)
                .padding(.top, 10)
            }

            HStack {
                Text("Already registered?")
                    .foregroundColor(.gray)

                Button("Login Now") {
                    dismiss()
                }
                .fontWeight(.bold)
                .foregroundColor(.black)
            }
            .font(.callout)
            .vAlign(.bottom)
        }
        .vAlign(.top)
        .padding(15)
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthManager())
}

extension View {
    func hAlign(_ alignment: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }

    func vAlign(_ alignment: Alignment) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }

    func border(_ width: CGFloat, _ color: Color) -> some View {
        self
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(color, lineWidth: width)
            }
    }

    func fillView(_ color: Color) -> some View {
        self
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(color)
            }
    }
}
