//
//  DetailedVoyageView.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 19.02.2026.
//

import SwiftUI
import MapKit

struct DetailedVoyageView: View {
    @StateObject var viewModel = VoyageViewModel()
    let voyage: VoyageModel
    @State var region: MKCoordinateRegion
    @StateObject var portViewModel = PortsViewModel()

    var body: some View {
        VStack{
            ZStack{
                ScrollView{
                    VStack(alignment: .leading, spacing: 20){
                        Map(coordinateRegion: $region, annotationItems: [voyage]){ item in
                            MapMarker(coordinate: CLLocationCoordinate2D(
                                latitude: viewModel.takeLat(port: portViewModel.ports_data[0]),
                                      longitude: viewModel.takeLong(port: portViewModel.ports_data[0])), tint:.blue)
                        }
                        .frame(height: 300)
                        .cornerRadius(20.0)
                        .padding()
                        
                        VStack(alignment: .leading) {
                            HStack{
                                Text(voyage.title)
                                    .font(.largeTitle).bold()
                                Spacer()
                                
                                Text("\(voyage.status)")
                                
                            }
                            
                            Text("Currently at: (current port)")
                                .font(.title3)
//                            ProgressBar()
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}


struct ProgressBar: View {
    @State private var progress: CGFloat = 0.0
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    var body: some View{
        ZStack(alignment: .leading){
            Rectangle()
                .frame(width: 300, height: 20)
                .opacity(0.3)
                .foregroundColor(.gray)
            
            Rectangle()
                .frame(width: progress * 300, height: 20)
                .foregroundColor(.green)
                .animation(.easeInOut, value: progress)
        }
        .onReceive(timer) { _ in
            if progress < 1.0 {
                progress += 0.01
            }
        }
    }
}

#Preview {
    DetailedVoyageView(voyage: VoyageViewModel().voyage_data[0],
                       region: MKCoordinateRegion())
}

//port: PortsViewModel().ports_data[1]
