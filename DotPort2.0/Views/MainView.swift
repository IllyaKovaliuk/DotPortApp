//
//  MainView.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 17.02.2026.
//

import SwiftUI
import MapKit

fileprivate enum MainTab: Hashable {
    case ports
    case ships
    case map
    case profile
    case plus
}

struct MainView: View {
    @State var todaysDate = Date.now
    @StateObject private var voyageViewModel = VoyageViewModel()
    @StateObject private var portsViewModel = PortsViewModel()
    @State private var navPath = NavigationPath()

    let statColumns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @EnvironmentObject var activityManager: ActivityManager
    @EnvironmentObject var auth: AuthManager

    private var activeVoyagesCount: Int {
        voyageViewModel.voyages.filter { $0.status == .InProgress || $0.status == .Shipped }.count
    }

    private var queuedVoyagesCount: Int {
        voyageViewModel.voyages.filter { $0.status == .Queued }.count
    }

    private var openBerthsCount: Int {
        portsViewModel.ports.filter { $0.berthStatus == .opened }.count
    }

    private var isOnHome: Bool {
        navPath.isEmpty
    }

    var body: some View {
        NavigationStack(path: $navPath) {
            ZStack {
                Color(red: 0.98, green: 0.98, blue: 0.96)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        VStack(alignment: .leading) {
                            Text("Today's active operations: \(activeVoyagesCount)")
                                .font(.headline)
                            Text(todaysDate, style: .date)
                                .fontWeight(.light)
                                .foregroundStyle(.secondary)
                        }

                        NavigationLink(destination: ProfileView()) {
                            MainAccountWindow(user: auth.currentUser)
                                .padding(.top, 20)
                        }

                        Text("Statistics")
                            .font(.title3).bold()
                            .padding(.top, 25)

                        Divider().padding(.vertical, 10)

                        LazyVGrid(columns: statColumns, spacing: 15) {
                            StatisticCell(title: "Active voyages", value: "\(activeVoyagesCount)")
                            StatisticCell(title: "Ships in queue", value: "\(queuedVoyagesCount)")
                            StatisticCell(title: "Berth availability", value: "\(openBerthsCount)")
                            StatisticCell(title: "Total voyages", value: "\(voyageViewModel.voyages.count)")
                        }

                        Divider().padding(.vertical, 20)

                        Text("Active Operations")
                            .font(.title3).bold()
                            .padding(.bottom, 10)

                        if voyageViewModel.isLoading && voyageViewModel.voyages.isEmpty {
                            ProgressView("Loading voyages...")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 24)
                        } else if voyageViewModel.voyages.isEmpty {
                            Text("No active voyages yet")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 24)
                        } else {
                            ForEach(voyageViewModel.voyages) { voyage in
                                NavigationLink(destination: DetailedVoyageView(voyage: voyage)) {
                                    OperationCell(voyage: voyage)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .padding(.bottom, 10)
                            }
                        }
                    }
                    .padding(25)
                }
                .onAppear {
                    voyageViewModel.timerFetching()
                    portsViewModel.timerFetch()
                }
                .onDisappear {
                    voyageViewModel.stopTimer()
                    portsViewModel.stopAutoUpdate()
                }
            }
            TabBar(isOnHome: isOnHome) { tab in
                switch tab {
                case nil:
                    navPath = NavigationPath()
                case .some(let destination):
                    navPath = NavigationPath()
                    navPath.append(destination)
                }
            }
            .padding(.bottom, 10)
            .navigationDestination(for: MainTab.self) { tab in
                switch tab {
                case .ports: PortsView()
                case .ships: ShipsView()
                case .map: MapView()
                case .profile: ProfileView()
                case .plus: PlusVoyageView()
                }
            }
        }
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

struct MainAccountWindow: View {
    let user: UserModel?

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 15) {
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.15))
                        .frame(width: 60, height: 60)
                    Text(user?.initials ?? "U")
                        .font(.title3.bold())
                        .foregroundColor(.white)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(user?.displayName ?? "Guest")
                        .font(.headline)
                        .foregroundColor(.white)

                    Text(user?.safeRole ?? "Worker")
                        .font(.subheadline)
                        .opacity(0.8)
                        .foregroundColor(.white)
                }

                Spacer()
            }
        }
        .padding()
        .background(Color(red: 43/255, green: 50/255, blue: 63/255))
        .cornerRadius(20)
        .foregroundColor(.white)
    }
}

struct OperationCell: View {
    @State var isFav: Bool = false
    let voyage: VoyageItem

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(voyage.title)
                    .font(.headline)
                Spacer()
                heartEmodji
            }
            Text(voyage.status.title)
            Text("\(voyage.fromPort) → \(voyage.toPort)")
                .font(.caption)
                .opacity(0.85)
        }
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

fileprivate struct TabBar: View {
    let isOnHome: Bool
    let onSelect: (MainTab?) -> Void

    var body: some View {
        HStack {
            TabBarButton(icon: "house.fill", isActive: isOnHome, isDisabled: isOnHome) {
                onSelect(nil)
            }
            TabBarButton(icon: "door.sliding.right.hand.open") {
                onSelect(.ports)
            }
            TabBarButton(icon: "ferry.fill") {
                onSelect(.ships)
            }
            TabBarButton(icon: "map.fill") {
                onSelect(.map)
            }
            TabBarButton(icon: "person.fill") {
                onSelect(.profile)
            }
            TabBarButton(icon: "plus") {
                onSelect(.plus)
            }
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

fileprivate struct TabBarButton: View {
    let icon: String
    var isActive: Bool = false
    var isDisabled: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .semibold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .foregroundStyle(isActive ? Color.blue : Color.primary)
                .opacity(isDisabled ? 0.35 : 1)
        }
        .disabled(isDisabled)
    }
}

#Preview {
    MainView()
        .environmentObject(ActivityManager())
        .environmentObject(AuthManager())
}
