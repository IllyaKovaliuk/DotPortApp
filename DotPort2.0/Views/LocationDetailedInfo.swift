//
//  LocationDetailedInfo.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 09.03.2026.
//

import SwiftUI

struct LocationDetailedInfo: View {
    let location: PortModel
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 10){
                Text(location.name)
                    .font(.title)
                    .fontWeight(.bold)
                Text(location.country)
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            Divider()
            if ((location.description?.isEmpty) != nil){
                Text(location.description!)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
            VStack{
                HStack{
                    Text("How many burthes in port now -")
                        .font(.subheadline)
                        
                    Text("\(location.burthCount)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .background(Material.ultraThinMaterial)
        
    }
}

#Preview {
    LocationDetailedInfo(location: Mocks.port1)
}
