//
//  PortsView.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 19.02.2026.
//

import SwiftUI

struct PortsView: View {
    @Environment (\.dismiss) var dismiss
    @StateObject private var vm = PortsViewModel()
    var body: some View {
        //        ZStack(alignment: .topLeading){
        ScrollView{
            ForEach(vm.ports){ port in
                NavigationLink(destination: DetailedPortView(port: port)){
                    VStack{
                        HStack{
                            Text("Port of \(port.name)")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Spacer()
                            Text("Ships count: \(port.shipsCount)")
                        }
                        .padding()
                        Divider()
                            .background(Color(.white))
                        HStack{
                            VStack{
                                Text("Total Berth")
                                Text("\(port.berthCount)")
                            }
                            
                            .padding(2)
                            Spacer()
                            VStack{
                                Text("Available")
                                Text("\(port.berthCount)")
                                    .foregroundColor(.green)
                            }
                            Spacer()
                            VStack{
                                Text("In queue")
                                Text("\(port.berthCount)")
                                    .foregroundColor(.red)
                            }
                            
                        }
                        .padding()
                        .font(.system(size: 15))
                        .frame(alignment: .leading)
                        .foregroundColor(.white)
                    }
                }
                
                .fontDesign(.monospaced)
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(red: 43/255, green: 50/255, blue: 63/255))
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(10)
                .shadow(radius: 5)
                
                .navigationTitle("Ports")
            }
            
//            .ignoresSafeArea()
//            .navigationBarBackButtonHidden(false)
//            .navigationBarHidden(true)
            
            Spacer()
            
        }
        .onAppear{vm.timerFetch()}
        .onDisappear{vm.stopAutoUpdate()}
    }
    
}
#Preview {
    PortsView()
}
