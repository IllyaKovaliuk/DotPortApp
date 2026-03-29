//
//  TestingView.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 27.03.2026.
//

import SwiftUI

struct TestingView: View {
//  var fetchVoyages : GetVoyages
    var fetchPorts: FetchPorts
//  @State var voyages: [Voyage] = []
    @State var portses: [PortModel] = []
    var body: some View {
        VStack{
            List(portses, id: \.id) { port in
                                VStack(alignment: .leading) {
                                    Text(port.name)
                                        .font(.headline)
                                    Text("From: \(port.country) to \(port.shipsCount)")
                                        .font(.caption)
                        }
                }
            
            Button("test"){
                Task{
                    do {
                        let ports = try await fetchPorts.getPorts()
                        await MainActor.run{
                            self.portses = ports
                        }
                        print("I get \(ports.count) voyages")
                    } catch let decodingError as DecodingError {
                    switch decodingError {
                    case .keyNotFound(let key, _):
                        print("❌ Не знайдено ключ: \(key.stringValue)")
                    case .typeMismatch(let type, let context):
                        print("❌ Невідповідність типу: \(type) для ключа \(context.codingPath.last?.stringValue ?? "")")
                    case .valueNotFound(let type, let context):
                        print("❌ Значення не знайдено: \(type) для ключа \(context.codingPath.last?.stringValue ?? "")")
                    case .dataCorrupted(let context):
                        print("❌ Дані пошкоджені: \(context)")
                    @unknown default:
                        print("❌ Невідома помилка декодування")
                    }
                    throw NetErrorrs.BadData
                }
                }
            }
        }
    }
}

#Preview {
    TestingView(fetchPorts: FetchPorts())
//        .modelContainer(for: Voyage.self, inMemory: true)
}
