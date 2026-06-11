import SwiftUI

struct ListOfLocations: View {
    @StateObject private var vm = MapViewModel.shared
    
    var body: some View {
        List {
            ForEach(vm.viewModelPorts.ports) { port in
                Button {
                    vm.showLocation(location: port)
                } label: {
                    HStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(port.name)
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Text(port.country)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Text("\(port.berthCount)")
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(.blue)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .contentShape(Rectangle())
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    ListOfLocations()
}
