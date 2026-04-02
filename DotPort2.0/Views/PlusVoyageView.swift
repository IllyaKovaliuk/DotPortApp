import SwiftUI
import SwiftData

struct PlusVoyageView: View {
    @Environment(\.modelContext) private var modelContext

    @StateObject private var portVm = PortsViewModel()
    @StateObject private var shipVm = ShipsViewModel()

    @State private var title: String = ""
    @State private var departureDate: Date = Date()
    @State private var arrivalDate: Date = Date()
    @State private var fromPort: String = ""
    @State private var toPort: String = ""
    @State private var shipId: String = ""
    @State private var portId: String = ""

    var body: some View {
        Form {
            Section("Voyage title") {
                TextField("Title", text: $title)
            }

            Section("Departure Date") {
                DatePicker("Select Date", selection: $departureDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
            }

            Section("Arrival Date") {
                DatePicker("Select Date", selection: $arrivalDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
            }

            Picker("From Port", selection: $fromPort) {
                ForEach(portVm.ports, id: \.id) { port in
                    Text(port.name).tag(port.name)
                }
            }
//            Picker("From Port", selection: $portId) {
//                ForEach(portVm.ports_data, id: \.id) { port in
//                    Text(port.id).tag(port.id)
//                }
//            }

            Picker("To Port", selection: $toPort) {
                ForEach(portVm.ports, id: \.id) { port in
                    Text(port.name).tag(port.name)
                }
            }

            Picker("Ships", selection: Binding(
                get: { shipId },
                set: { shipId = $0 }
            )) {
                ForEach(shipVm.ships) { ship in
                    // Показуємо Юзеру - НАЗВУ (ship.name)
                    // Відправляємо в базу - ID (ship.id)
                    Text(ship.name).tag(ship.id)
                }
            }

            
        }
        .navigationTitle("Add new voyage")
        .onAppear {
            setDefaultsIfNeeded()
        }
        .onChange(of: portVm.ports) {
            setDefaultsIfNeeded()
        }
        .onChange(of: shipVm.ships) {
            setDefaultsIfNeeded()
        }
        
        Button("Confirm Voyage") {
            createVoyage()
        }
        .buttonStyle(.borderedProminent)
    }

    func setDefaultsIfNeeded() {
        if fromPort.isEmpty, let firstPort = portVm.ports.first {
            fromPort = firstPort.name
        }

        if toPort.isEmpty, let firstPort = portVm.ports.first {
            toPort = firstPort.name
        }

        if shipId.isEmpty, let firstShip = shipVm.ships.first {
            shipId = firstShip.name
        }
    }

    func createVoyage() {
        let voyageActor = GetVoyages()

        let newVoyage = VoyageDTO(
            id: UUID().uuidString,
            title: title,
            status: .Queued,
            departureDate: departureDate,
            arrivalDate: arrivalDate,
            progressPercent: 0,
            createdBy: "MobileUser",
            createdAt: Date.now,
            updatedAt: Date.now,
            userId: nil,
            routeId: nil,
            shipId: shipId,
            workerId: nil,
            portId: portId,
            containerCounts: 0,
            fromPort: fromPort,
            toPort: toPort
        )

        Task {
            do {
                try await voyageActor.postVoyage(newVoyage: newVoyage)
                print("✅ Success")
                print("FROM PORT: \(fromPort)")
                print("TO PORT: \(toPort)")
                print("SHIP: \(shipId)")
            } catch {
                print("❌ Fail: \(error)")
            }
        }
    }
}
            


#Preview {
    PlusVoyageView()
        .modelContainer(for: Voyage.self, inMemory: true)
}
