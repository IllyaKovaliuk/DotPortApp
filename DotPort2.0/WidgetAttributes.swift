//
//  WidgetAttributes.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 04.03.2026.
//

import Foundation
import ActivityKit

struct WidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable{
        var progress: Double
        var status: VoyageSatatus
        var timeDelivery: Date
        var fromPort: String
        var toPort: String
        var captainName: String
        var currentLocation: String
    }
    var voyageId: String
    var userId: String
    var shipName: String
    var containerCount: Int
    
}

enum VoyageSatatus: String, Codable, CaseIterable {
    case loading = "Loading"
    case unloading = "Unloading"
    case inProgress = "In progress"
    case done = "Done"
    case starting = "Staring"
    
    var emojies: String {
        switch self{
        case .loading: return "🏗️"
        case .unloading: return "🏗️"
        case .inProgress: return "⏳"
        case .done: return "✅"
        case .starting: return "🏁"
        }
    }
}
