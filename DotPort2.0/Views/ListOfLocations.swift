import SwiftUI

struct ListOfLocations: View {
    @StateObject private var vm = MapViewModel.shared
    
    var body: some View {
        List {
            // Використовуємо ForEach всередині List — це стандарт для SwiftUI
            ForEach(vm.viewModelPorts.ports) { port in
                Button {
                    vm.showLocation(location: port)
                } label: {
                    // Використовуємо HStack замість ZStack для горизонтального розміщення
                    HStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(port.name)
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Text(port.country)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer() // Штовхає текст нижче вправо
                        

                        
                        // Переконайся, що в моделі саме berthCount (через e)
                        // Якщо все ж таки залишив burthCount — заміни тут назад на u
                        Text("\(port.berthCount)")
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(.blue)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .contentShape(Rectangle()) // Щоб весь рядок був клікабельним
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    // Додаємо контейнер, якщо твоя в'юшка залежить від SwiftData,
    // або просто валідуємо інтерфейс
    ListOfLocations()
}
