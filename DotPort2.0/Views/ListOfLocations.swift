//
//  ListOfLocations.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 08.03.2026.
//

import SwiftUI

struct ListOfLocations: View {
    @StateObject private var vm = MapViewModel.shared
    
    var body: some View {
        List{
            ForEach(vm.ports){port in
                Button {
                    vm.showLocation(location: port)
                }
                label :{
                    ZStack {
                        VStack(alignment: .leading){
                            Text(port.name)
                                .font(.headline)
                            Text(port.country)
                                .font(.subheadline)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        HStack{
                            Spacer()
                            Text("\(port.burthCount)")
                        }
                    }
                    
                    
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
