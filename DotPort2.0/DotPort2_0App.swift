//
//  DotPort2_0App.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 02.02.2026.
//

import SwiftUI
import SwiftData

@main
struct DotPort2_0App: App {
    @StateObject private var activityManager = ActivityManager()
//    @StateObject private var vm = MapViewModel()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(activityManager)
//                .environmentObject(vm)
        }
        .modelContainer(for: Voyage.self)
    }
}
