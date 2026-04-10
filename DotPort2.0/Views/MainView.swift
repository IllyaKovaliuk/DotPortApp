//
//  MainView.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 17.02.2026.
//

import SwiftUI
import MapKit

struct MainView: View {
    @State var todaysDate = Date.now
    @StateObject private var viewModel = MainVM()
    @StateObject var voyageViewModel = VoyageViewModel()
    @State private var selectedTab = 0
    let statColumns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @EnvironmentObject var activityManager: ActivityManager
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.98, green: 0.98, blue: 0.96)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        
                        VStack(alignment: .leading){
                            Text("Today's active operations: \(viewModel.voyages.count)")
                                .font(.headline)
                            Text(todaysDate, style: .date)
                                .fontWeight(.light)
                                .foregroundStyle(.secondary)
                        }
                        
                        MainAccountWindow(modelWork: workerData)
                            .padding(.top, 20)
                        
                        Text("Statistics")
                            .font(.title3).bold()
                            .padding(.top, 25)
                        
                        Divider().padding(.vertical, 10)
                        
                        LazyVGrid(columns: statColumns, spacing: 15) {
                            StatisticCell(title: "Active ships", value: viewModel.activeVoyagesCount)
                            StatisticCell(title: "Ships in queue", value: viewModel.queueShips)
                            StatisticCell(title: "Berth Availability", value: viewModel.berthAvailability)
                            StatisticCell(title: "Fueling Ops", value: viewModel.activeVoyagesCount)
                        }
                        
                        Divider().padding(.vertical, 20)
                        
                        Text("Active Operations")
                            .font(.title3).bold()
                            .padding(.bottom, 10)
                        
                        ForEach(viewModel.voyages) { voyage in
                            NavigationLink(destination: DetailedVoyageView(region: MKCoordinateRegion())) {
                                OperationCell(
//                                    timeShip: "ETA: 2h 15m", voyage: voyage
                                )
                                .onAppear{ voyageViewModel.timerFetching() }
                                .onDisappear{ voyageViewModel.stopTimer() }
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.bottom, 10)
                        }
                        
                    }
                    .padding(25)
                    
                }
                
                
            }
            TabBar()
                .padding(.bottom, 10)
            
        }
//                Button("Test Island") {
//                    activityManager.startLiveActivity(for: VoyageViewModel().voyage_data[0])
//                }
         }
}
    
    struct StatisticCell: View {
        let title: String
        let value: String
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.headline)
                    .bold()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
    }
    
    struct StatItem: View {
        let value: String
        let label: String
        
        var body: some View {
            VStack(alignment: .leading, spacing: 4) {
                Text(value)
                    .font(.title2)
                    .bold()
                Text(label)
                    .font(.caption)
                    .opacity(0.7)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    struct MainAccountWindow: View{
        var modelWork: [WorkerModel]
        var body: some View{
            VStack(alignment: .leading, spacing: 20) {
                
                HStack(spacing: 15) {
                    if let worker = modelWork.first{
                        Image(worker.photo!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white.opacity(0.5), lineWidth: 1))
                        
                        VStack(alignment: .leading, spacing: 4) {
                            if let worker = modelWork.first {
                                Text(worker.firstName + " " + worker.lastName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                Text(worker.position.rawValue)
                                    .font(.subheadline)
                                    .opacity(0.8)
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Spacer()
                    }
                }
                
                Divider().background(Color.white.opacity(0.3))
                
                HStack {
                    StatItem(value: "100%", label: "Success Rate")
                    StatItem(value: "1247", label: "Operations")
                    StatItem(value: "12", label: "Years Exp")
                }
            }
            .padding()
            .background(Color(red: 43/255, green: 50/255, blue: 63/255))
            .cornerRadius(20)
            .foregroundColor(.white)
            
        }
    }
    
    struct OperationCell: View {
//        let title: String
//        let subTitle: String
//        let status: VoyageStatus
//        let timeShip: String
        @State var isFav: Bool = false
//        let voyage: Voyage
        @StateObject var viewModel = VoyageViewModel()
        var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    ForEach(viewModel.voyages){ voyage in
                        Text(voyage.title)
                            .font(.headline)
                        Spacer()
                        heartEmodji
                        HStack {
                            Text("\(voyage.status)")
                            Spacer()
                        }
                    }
                }
            }
            .onAppear{ viewModel.timerFetching() }
            .onDisappear{ viewModel.stopTimer() }
            .padding()
            .background(Color(red: 43/255, green: 50/255, blue: 63/255))
            .foregroundColor(.white)
            .cornerRadius(12)
        }
        @ViewBuilder
        var heartEmodji: some View {
            Image(systemName: isFav ? "heart.fill" : "heart")
                .foregroundColor(isFav ? .red : .gray)
                .onTapGesture {
                    isFav.toggle()
                }
        }
    }
    
    struct TabBar: View{
        @State private var portPath = PortsView()
        @StateObject private var viewModel = MainVM()
        //    @Binding var selectedTab: Int
        //    @State var closedBoard = 0
        var body: some View{
            
            HStack{
                ButtonCell(navigationDestination: MainView() , customIcon: "house.fill")
                    .disabled(viewModel.currentPage == .dashboard)
                //                .disabled(closedBoard == 0)
                ButtonCell(navigationDestination: PortsView(), customIcon: "door.sliding.right.hand.open")
                ButtonCell( navigationDestination: ShipsView() , customIcon: "ferry.fill")
                ButtonCell(navigationDestination: MapView(), customIcon: "map.fill")
                ButtonCell( navigationDestination: ProfileView(), customIcon: "person.fill")
                ButtonCell(navigationDestination: PlusVoyageView(), customIcon: "plus")
                // онлі для воркер акаунта
                
                
            }
            .foregroundColor(.black)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(.ultraThinMaterial)
            .clipShape(Capsule())
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
            .padding(.horizontal)
            
            
        }
    }
    
    
    struct ButtonCell<Destination: View>: View {
        let navigationDestination: Destination
        let customIcon: String
        
        var body: some View{
            NavigationLink(destination: navigationDestination){
                HStack{
                    
                    Image(systemName: customIcon)
                        .font(.system(size: 20, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .contentShape(Rectangle())
                }
            }
            
        }
    }
    

#Preview {
    MainView()
        .environmentObject(ActivityManager())
        
}


