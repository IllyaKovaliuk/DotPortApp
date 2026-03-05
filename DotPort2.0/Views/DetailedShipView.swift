//
//  DetailedShipView.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 23.02.2026.
//

import SwiftUI

struct DetailedShipView: View {
    let ship: ShipModel
    var body: some View {
        Text("Тут буде інфа про капасіті фуель актівний не актівний караблік і тд")
        HStack{
            VStack{
                Text("Capacity")
                Text("\(ship.capacity_weight)")
            }
            Spacer()
            VStack{
                Text("Fuel")
                /*Text(shipViewModel.fuelСalculation(distance: VoyageViewModel().voyage_data[0], horsepower: ship.estimatedPower, weight: ship.capacity_weight ))*/
            }
            Spacer()
            VStack{
                Text("Crew")
            }
        }
    }
}

#Preview {
    DetailedShipView(ship: ShipsViewModel().ships_data[0])
}


//port: PortsViewModel().ports_data[0]
