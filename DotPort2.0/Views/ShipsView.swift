import SwiftUI

struct ShipsView: View {
    @StateObject var shipViewModel = ShipsViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("\(shipViewModel.countShips): ships found")
                        .padding(.horizontal)
                        .padding(.top)
                        .fontDesign(.monospaced)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                    Spacer()
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(shipViewModel.ships_data) { ship in
                            NavigationLink(destination: DetailedShipView(ship: ship)) {
                                MyShipCard(ship: ship)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(20)
                }
                
                Spacer()
            }
            .background(Color(white: 0.95))
            .navigationTitle("List of ships")
        }
    }
}


struct MyShipCard: View {
    let ship: ShipModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Картинка (тут затуп чи просто імедж чи асінк імедж)
            AsyncImage(url: URL(string: ship.imageName ?? "Sorry")) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 350)
                    .clipped()
            } placeholder: {
                ZStack {
                    Color.gray.opacity(0.1)
                    ProgressView()
                }
                .frame(width: 250, height: 350)
            }

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(ship.name)
                        .fontWeight(.bold)
                    Spacer()
                    Text("\(ship.status)")
                        .font(.caption)
                        .padding(4)
                        .background(Color.green.opacity(0.2))
                        .cornerRadius(4)
                }
                
                Text("ID: \(ship.id)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Capacity").font(.system(size: 10))
                        Text("\(ship.capacity_weight)").fontWeight(.semibold)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Fuel").font(.system(size: 10))
                        Text("Calculated...").fontWeight(.semibold)
                    }
                }
            }
            .padding()
            .frame(width: 250)
            .background(Color(red: 43/255, green: 50/255, blue: 63/255))
            .foregroundColor(.white)
            .fontDesign(.monospaced)
        }
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    ShipsView()
}
