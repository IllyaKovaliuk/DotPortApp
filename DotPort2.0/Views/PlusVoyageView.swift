import SwiftUI
import SwiftData

struct PlusVoyageView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var viewModel: PlusViewModel?
    @StateObject private var portVm = PortsViewModel()
    @StateObject private var shipVm = ShipsViewModel()

    var body: some View {
        Group {
            if let viewModel {
                Form {
                    Section("Voyage title") {
                        TextField("Title", text: Binding(
                            get: { viewModel.title },
                            set: { viewModel.title = $0 }
                        ))
                    }

                    Section("Departure Date") {
                        DatePicker("Select Date", selection: Binding(
                            get: { viewModel.departureDate },
                            set: { viewModel.departureDate = $0 }
                        ), displayedComponents: .date)
                        .datePickerStyle(.graphical)
                    }

                    Section("Arrival Date") {
                        DatePicker("Select Date", selection: Binding(
                            get: { viewModel.arrivalDate },
                            set: { viewModel.arrivalDate = $0 }
                        ), displayedComponents: .date)
                        .datePickerStyle(.graphical)
                    }

                    Picker("From Port", selection: Binding(
                        get: { viewModel.fromPort },
                        set: { viewModel.fromPort = $0 }
                    )) {
                        ForEach(portVm.ports_data, id: \.id) { port in
                            Text(port.name).tag(port.name)
                        }
                    }

                    Picker("To Port", selection: Binding(
                        get: { viewModel.toPort },
                        set: { viewModel.toPort = $0 }
                    )) {
                        ForEach(portVm.ports_data, id: \.id) { port in
                            Text(port.name).tag(port.name)
                        }
                    }

                    Section("Ship for your voyage") {
                        Picker("Ships", selection: Binding(
                            get: { viewModel.shipId },
                            set: { viewModel.shipId = $0 }
                        )) {
                            ForEach(shipVm.ships_data, id: \.id) { ship in
                                Text(ship.name).tag(ship.name)
                            }
                        }
                    }

                    Button("Confirm Voyage") {
                        viewModel.createVoyage()
                    }
                    .buttonStyle(.borderedProminent)
                }
            } else {
                ProgressView("Loading...")
                    .onAppear {
                        viewModel = PlusViewModel(context: modelContext)
                    }
            }
        }
        .navigationTitle("Add new voyage")
    }
}
            


#Preview {
    PlusVoyageView()
        .modelContainer(for: Voyage.self, inMemory: true)
}
