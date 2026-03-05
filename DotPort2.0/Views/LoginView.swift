//
//  LoginView.swift
//  DotPort
//
//  Created by Illya Kovaliuk on 24.01.2026.
//

import SwiftUI


struct LoginView: View {
    @StateObject private var viewModel = loginVM()
    @State var accounted: Bool = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 10){
            Text("Sign in")
                .font(.largeTitle.bold())
            
            
            Text("Glad to see you again")
                .font(.title)
                .hAlign(.leading)
            
            VStack(spacing: 13){
                TextField("Email", text: $viewModel.email)
                    .textContentType(.emailAddress)
                    .border(1, .gray.opacity(0.5))
                    .padding(.top, 25)
                
                SecureField("Password", text: $viewModel.password)
                    .textContentType(.emailAddress)
                    .border(1, .gray.opacity(0.5))
                    .padding(.top, 25)
                
                Button("Reset Password", action: loginUser)
                    .font(.callout)
                    .fontWeight(.medium)
                    .tint(.black)
                    .hAlign(.center)
                
                Button{
                    
                }
                    label:{
                    Text("Sign in")
                            .foregroundColor(.white)
                            .hAlign(.center)
                            .fillView(Color(red: 43/255, green: 50/255, blue: 63/255))
                }
                    .padding(.top, 10)

            }
            
            HStack{
                Text("Do not have any account")
                    .foregroundColor(.gray)
                
                Button("Register Now"){
                    accounted.toggle()
                }
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            }
            .font(.callout)
            .vAlign(.bottom)
            .fullScreenCover(isPresented: $accounted){
                RegisterView()
            }
//            .alert($viewModel.errorMessage, isPresented: $viewModel.showError, actions: {} )
            
        }
        .vAlign(.top)
        .padding(15)
    }
    func loginUser(){
//        Task{
//            do{
//                try await Auth.auth().signIn(withEmail: emailID, password: password)
//                print("I catch user")
//            } catch{
//                await setError(error)
//            }
//        }
    }
    
    func setError(_ error: Error)async {
        await MainActor.run(body: {viewModel.errorMessage = error.localizedDescription
            viewModel.showError.toggle()
        })
    }
}


struct RegisterView: View {
    @State var emailID: String = ""
    @State var password: String = ""
    @State var workerID: String = ""
    @State var portID: String = ""
    @Environment(\.dismiss) var dismiss
    @State var groupUser: String = ""
    let groups = ["Worker", "User"]
    var body: some View {
        VStack(spacing: 10){
            Text("Register in")
                .font(.largeTitle.bold())
            
            
            VStack(spacing: 13){
                TextField("Email", text: $emailID)
                    .textContentType(.emailAddress)
                    .border(1, .gray.opacity(0.5))
                    .padding(.top, 25)
                
                SecureField("Password", text: $password)
                    .textContentType(.emailAddress)
                    .border(1, .gray.opacity(0.5))
                    .padding(.top, 25)
                
                TextField("Work id", text: $workerID)
                    .textContentType(.emailAddress)
                    .border(1, .gray.opacity(0.5))
                    .padding(.top, 25)
                
                TextField("Port id", text: $portID)
                    .textContentType(.emailAddress)
                    .border(1, .gray.opacity(0.5))
                    .padding(.top, 25)
                
                Picker("Role", selection: $groupUser){
                    ForEach(groups, id: \.self){group in
                        Text(group)
                    }
                    .border(1, .gray.opacity(0.5))
                    .padding(.top, 25)
                }
                
                
                Button{
                }
                    label:{
                    Text("Sign in")
                            .foregroundColor(.white)
                            .hAlign(.center)
                            .fillView(Color(red: 43/255, green: 50/255, blue: 63/255))
                }
                    .padding(.top, 10)
            }
            
            HStack{
                Text("Already registered?")
                    .foregroundColor(.gray)
                
                Button("Login Now"){
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
}

extension View{
    func hAlign(_ alignment: Alignment) -> some View{
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func vAlign(_ alignment: Alignment) -> some View{
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
    
    func border(_ width: CGFloat, _ color: Color) -> some View{
        self
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background{
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(color, lineWidth: width)
            }
    }
    
    func fillView(_ color: Color) -> some View{
        self
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background{
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(color)
            }
        
    }
}

