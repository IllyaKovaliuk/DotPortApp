//
//  PlusVoyageView.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 21.02.2026.
//

import SwiftUI

struct PlusVoyageView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: PlusViewModel?
    @State var groupPort: String = ""
        // получається це вікно буде тільки для воркерів
        // для воркера буде функція створити вояж також при переході на будь який вояж буде рядом кнопка або старт або стоп вояжа, що логічно воркер може зупини вояж по якійсь причині наприклад поломка, в інших випадках вояж має зупинитись сам після прибуття по координати тобто якшо координати корабля дорівнюють координатам вояжа стопається вояж. Як тоді відслідковувати де вояж де корабель. Інший простіший варіант дати заготовляний час для вояжа наприклад з одеси до пекіна пливти 40 годин по виходу часу вояж стопається
        //
        //
        var body: some View {
            Group {
                if let viewModel {
                    Form {
                        Section("Voyage title"){
                            TextField("Title", text: Binding(
                                get: { viewModel.voyage.title },
                                set: { viewModel.voyage.title = $0 }
                            ))
                        }
                        Section("Departure Date"){
                            DatePicker("Select Date", selection: Binding(
                                get: { viewModel.voyage.createdAt },
                                set: {viewModel.voyage.createdAt = $0}
                            ), displayedComponents: .date)
                            .datePickerStyle(.graphical)
                        }
                        Section("Arrival Date"){
                            DatePicker("Select Date", selection: Binding(
                                get: { viewModel.voyage.arrivalDate },
                                set: {viewModel.voyage.arrivalDate = $0}
                            ), displayedComponents: .date)
                            .datePickerStyle(.graphical)
                        }

                        TextField("To port", text: Binding(
                            get: { viewModel.voyage.toPort },
                            set: { viewModel.voyage.toPort = $0 }
                        ))
                    }
                } else {
                    Text("Loading...")
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
