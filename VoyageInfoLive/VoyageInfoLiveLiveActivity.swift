//
//  VoyageInfoLiveLiveActivity.swift
//  VoyageInfoLive
//
//  Created by Illya Kovaliuk on 04.03.2026.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct WidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WidgetAttributes.self ) { context in
            // Lock screen/banner UI goes here
             ShipLiveActivityView(
                attributes: context.attributes,
                state: context.state
            )
        } dynamicIsland: { context in
            // Dynamic Island UI goes here
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading){
                    HStack{
                        Image(systemName: "ferry.fill")
                            .foregroundColor(.orange)
                        Text(context.attributes.shipName)
                            .font(.caption)
                            .fontDesign(.monospaced)
                    }
                }
                DynamicIslandExpandedRegion(.trailing){
                    Text(context.state.timeDelivery, style: .timer)
                        .font(.caption)
                        .fontDesign(.monospaced)
                        .foregroundStyle(.secondary)
                }
                DynamicIslandExpandedRegion(.center){
                    Text(context.state.status.rawValue)
                        .font(.caption)
                        .fontWeight(.medium)
                }
                DynamicIslandExpandedRegion(.bottom){
                    HStack{
                        Text(context.attributes.userId)
                            .font(.caption)
                            .fontDesign(.monospaced)
                        Spacer()
                        Text(context.state.captainName)
                    }
                    .foregroundColor(.secondary)
                }
            } compactLeading: {
                Image(systemName: "ferry.fill")
                    .foregroundColor(.orange)
            } compactTrailing: {
                Text(context.state.timeDelivery, style: .timer)
                    .font(.caption)
                    .fontDesign(.monospaced)
            } minimal: {
                Image(systemName: "bag.fill")
                    .foregroundColor(.orange)
            }
        }
    }
}

struct ShipLiveActivityView: View {
    let attributes: WidgetAttributes
    let state: WidgetAttributes.ContentState
    
    var body: some View {
        VStack(spacing: 12){
            //Header
            HStack{
                Image(systemName: "ferry.fill")
                    .foregroundColor(Color("MyPortColor"))
                    .font(.title2)
                
                VStack(alignment: .leading){
                    Text("Voyage id \(attributes.voyageId)")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text(attributes.shipName)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                }
                Spacer()
                
                VStack(alignment: .trailing){
                    Text("Containers")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(state.timeDelivery, style: .timer)
                        .font(.caption)
                        .fontDesign(.monospaced)
                }
            }
            //progres bar
            
            HStack{
                ForEach(VoyageSatatus.allCases, id: \.self){ status in
                    HStack{
                        Circle()
                            .fill(state.status == status ? Color.orange : Color.gray.opacity(0.3))
                            .frame(width: 12, height: 12)
                        
                        if status != VoyageSatatus.allCases.last {
                            Rectangle()
                                .fill(shouldShowProgress(current: state.status, target: status) ?
                                      Color.orange : Color.gray.opacity(0.3))
                                .frame(height: 2)
                        }
                    }
                    
                }
            }
            HStack(){
                Text("\(state.status.emojies) \(state.status.rawValue)")
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Spacer()
                
                if state.status == .inProgress {
                    Text("📍 \(state.currentLocation)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
                .padding(16)
                .background(Color(UIColor.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 2)
        
    }
    private func shouldShowProgress(current: VoyageSatatus, target: VoyageSatatus) -> Bool {
        let allCases = VoyageSatatus.allCases
        guard let currentIndex = allCases.firstIndex(of: current),
              let targetIndex = allCases.firstIndex(of: target) else {
            return false
        }
        return currentIndex > targetIndex
    }
}
