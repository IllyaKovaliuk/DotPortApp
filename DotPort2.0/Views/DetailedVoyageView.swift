//
//  DetailedVoyageView.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 19.02.2026.
//

import SwiftUI
import MapKit
import SwiftData

struct DetailedVoyageView: View {
    @StateObject var viewModel = VoyageViewModel()
    let voyage: Voyage
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
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Voyage.self, configurations: config)
        
        // Заповни всі необхідні параметри
        let sample = Voyage(
            title: "MSC Gülsün",
            status: .InProgress,
            departureDate: Date(),
            arrivalDate: Date(),
            createdBy: "Admin",
            userId: "1",
            routeId: "1",
            shipId: "1",
            workerId: "1",
            portId: "1",
            containerCounts: 10,
            fromPort: "Rotterdam",
            toPort: "Singapore"
        )
        
        return DetailedVoyageView(voyage: sample, region: MKCoordinateRegion())
            .modelContainer(container)
}

//port: PortsViewModel().ports_data[1]
