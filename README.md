DotPort 🚢
High-Performance Maritime Logistics & Fleet Management System
DotPort 2.0 is a comprehensive iOS ecosystem designed for real-time tracking, port logistics, and fleet coordination. Built with a focus on memory efficiency and seamless data synchronization.

🛠 Tech Stack & Architecture
Frontend: SwiftUI (Declarative UI with focus on performance).

Data Persistence: SwiftData (Modern, safe local storage).

Geospatial: MapKit (Custom clustering and real-time vessel positioning).

Backend Integration: n8n Workflows & PostgreSQL (Neon) for automated data pipelines.

Architecture: Clean MVVM with Protocol-Oriented Design.

🚀 Key Engineering Challenges Solved
1. Robust Data Safety (Optionals Management)
Implemented a strict "Safe-Unwrap" policy across the entire app. By leveraging guard let, compactMap, and custom error handling, the app ensures zero runtime crashes when handling unpredictable API data.

2. Real-Time Geospatial Tracking
Integrated MapKit with custom overlay logic to visualize ship routes and port zones. Optimized rendering to handle multiple data points without dropping frames.

3. Automated Data Pipelines
Instead of a traditional monolith, I architected a serverless backend using n8n. This handles the ingestion of maritime data, processes it, and serves it to the iOS client via PostgreSQL (Neon), demonstrating a full-stack mindset.

📱 Features
Global Fleet Overview: Interactive maps with real-time ship positioning.

Port Management: Detailed views of port infrastructure and cargo status.

Offline Support: Intelligent caching using SwiftData for uninterrupted workflow in low-connectivity environments.

Fleet Analytics: Data-driven insights into logistics efficiency.

🛠 Installation & Setup
Clone the repo: git clone https://github.com/yourusername/DotPort.git

Environment: Requires Xcode 15.0+ and iOS 17.0+ (for SwiftData support).

Dependencies: No third-party package managers (Native Swift implementation).

🏗 Future Roadmap
[ ] Implementation of real-time WebSocket notifications for vessel arrivals.

[ ] AI-driven route optimization based on historical port congestion data.

[ ] Expansion to iPadOS for specialized terminal control views.
