import Foundation
import ActivityKit

class ActivityManager: ObservableObject {
    @Published var currentActivity: Activity<WidgetAttributes>?
    
    func startLiveActivity(for voyage: VoyageModel) {
        let attributes = WidgetAttributes(
            voyageId: voyage.id,
            userId: "User_777",
            shipName: voyage.shipId,
            containerCount: voyage.containerCounts
        )
        
        let initialState = WidgetAttributes.ContentState(
            progress: 0.0,
            status: .inProgress,
            timeDelivery: Date().addingTimeInterval(3600),
            fromPort: voyage.fromPort,
            toPort: voyage.toPort,
            captainName: "Kovaliuk I.",
            currentLocation: "Port Office"
        )
        
        do {
            currentActivity = try Activity<WidgetAttributes>.request(
                attributes: attributes,
                content: .init(state: initialState, staleDate: nil),
                pushType: nil
            )
            print("⚓️ Live Activity Started!")
        } catch {
            print("❌ Error starting Live Activity: \(error.localizedDescription)")
        }
    }
    
    func updateLiveActivity(progress: Double, status: VoyageSatatus, location: String) {
        guard let activity = currentActivity else { return }
        
        let updatedState = WidgetAttributes.ContentState(
            progress: progress,
            status: status,
            timeDelivery: Date().addingTimeInterval(1800),
            fromPort: activity.content.state.fromPort,
            toPort: activity.content.state.toPort,
            captainName: activity.content.state.captainName,
            currentLocation: location
        )
        
        Task {
            await activity.update(
                .init(state: updatedState, staleDate: nil)
            )
        }
    }
    
    func endLiveActivity() {
        guard let activity = currentActivity else { return }
        
        let finalState = WidgetAttributes.ContentState(
            progress: 1.0,
            status: .done,
            timeDelivery: Date(),
            fromPort: activity.content.state.fromPort,
            toPort: activity.content.state.toPort,
            captainName: activity.content.state.captainName,
            currentLocation: "Terminal A"
        )
        
        Task {
            await activity.end(
                .init(state: finalState, staleDate: nil),
                dismissalPolicy: .after(.now.addingTimeInterval(5))
            )
            
            DispatchQueue.main.async {
                self.currentActivity = nil
            }
        }
    }
}
