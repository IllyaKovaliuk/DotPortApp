//
//  DetailedShipView.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 23.02.2026.
//

import SwiftUI

struct DetailedShipView: View {
    let shipId: String
    @StateObject var viewModel = ShipsViewModel()
    var body: some View {
        VStack{
            if viewModel.isLoading {
                ProgressView()
            } else if let ship = viewModel.ship{
                DetailedShipCard(ship: ship)
            } else {
                Text("Loading...")
            }
        }
        .onAppear{viewModel.timerFetchId(id: shipId)}
        .onDisappear{viewModel.stopAutoUpdate()}
    }
}




// Тимчасова модель для прев'ю (можеш видалити, якщо вже є ShipModel)


struct DetailedShipCard: View {
    // Вхідні дані (заміни TempShip на свою ShipModel)
    let ship: ShipModel
    @StateObject var viewModel = ShipsViewModel()
    
    var body: some View {
        // Головний контейнер усього екрана
        ZStack {
            Color(.systemGray6).ignoresSafeArea() // Чистий світло-сірий фон
            
            VStack {
                // ВЕРХНЯ ЧАСТИНА (СТАТУС БАР В АПЦІ)
                HStack {
                    Button(action: { /* Повернутися назад */ }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding(16)
                            .background(Circle().fill(.white))
                    }
                    Spacer()
                    Text("3:49 📱") // Тимчасово, для стилю
                        .font(.caption)
                }
                .padding(.horizontal)
                
                Spacer().frame(height: 20)
                
                // ГОЛОВНА КАРТКА (Біла з закругленнями)
                VStack(alignment: .leading, spacing: 24) {
                    
                    // 1. ІМ'Я КОРАБЛЯ (Як великий корейський текст)
                    Text(ship.name.uppercased())
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5) // Шоб не вилазило
                        .padding(.top, 40)
                    
                    Divider()
                    
                    // 2. ДЕТАЛІ (Розбиті на колонки)
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("TYPE")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Text("Тип корабля")
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                        Spacer()
                        VStack(alignment: .trailing, spacing: 8) {
                            Text("CAPACITY (T)")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Text("\(ship.capacityWeight)")
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                    }
                    
                    Spacer() // Шоб текст був зверху
                    
                    // 3. НИЖНІЙ БЛОК НА КАРТЦІ (Там де було "Oppie")
                    HStack {
                        VStack(alignment: .leading) {
                            Text("ID: \(ship.id.prefix(8))") // Тільки 8 символів ID
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        // Мінімалістична точка-статус (напр. онлайн/офлайн)
                        Circle()
                            .fill(.green)
                            .frame(width: 12, height: 12)
                    }
                }
                .padding(32) // Великі внутрішні відступи
                .frame(maxWidth: .infinity, maxHeight: .infinity) // Займає все місце
                .background(
                    RoundedRectangle(cornerRadius: 36, style: .continuous)
                        .fill(.white) // Біла картка
                )
                .padding() // Зовнішній відступ картки від країв
                
                // НИЖНЯ ПАНЕЛЬ КНОПОК (Там де було "Shuffle")
                HStack(spacing: 16) {
                    Button(action: { /* Налаштування */ }) {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.black)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 20).fill(.white))
                    }
                    
                    // ГОЛОВНА КНОПКА (Як "Shuffle")
                    Button(action: { /* Почати рейс */ }) {
                        HStack {
                            Image(systemName: "play.fill")
                            Text("Start Voyage")
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 20).fill(.black))
                    }
                    
                    Button(action: { /* Додати примітку */ }) {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 20).fill(.white))
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
    }
}

// ПРЕВ'Ю (Запускай, шоб побачити красу)
#Preview {
    DetailedShipView(shipId: String())
}

//#Preview {
//    DetailedShipView(ship: ShipsViewModel().ships[2])
//}


//port: PortsViewModel().ports_data[0]
