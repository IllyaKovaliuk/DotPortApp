//
//  DotPort2_0App.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 02.02.2026.
//

import SwiftUI

@main
struct DotPort2_0App: App {
    @StateObject private var activityManager = ActivityManager()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(activityManager)
        }
    }
}
