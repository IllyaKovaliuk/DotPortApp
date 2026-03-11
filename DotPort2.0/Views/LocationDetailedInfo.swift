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
        
        VStack(alignment: .leading, spacing: 10){
            Text(location.name)
                .font(.title)
        }
        if ((location.description?.isEmpty) != nil){
            Text(location.description!)
                .frame(width: 300)
                
        }
    }
}

#Preview {
    LocationDetailedInfo(location: Mocks.port1)
}
