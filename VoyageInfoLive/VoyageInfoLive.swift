//
//  VoyageInfoLive.swift
//  VoyageInfoLive
//
//  Created by Illya Kovaliuk on 04.03.2026.
//


import WidgetKit
import Foundation
import SwiftUI

struct WidgetView: View{
    let progress: Double
    
    var body: some View{
        ZStack{
            Text("\(Int(progress * 10))")
                .font(.headline)
                .monospacedDigit()
            ProgressView(value: progress)
                .progressViewStyle(.circular)
                .frame(height: 25)
        }
    }
}


#Preview {
    WidgetView(progress: 0.7)
}
