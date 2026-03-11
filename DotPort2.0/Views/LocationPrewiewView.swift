//
//  LocationPrewiewView.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 09.03.2026.
//

import SwiftUI

struct LocationPrewiewView: View {
    @StateObject private var vm = MapViewModel.shared
    let location: PortModel
    
    var body: some View {
        HStack(){
            VStack(alignment: .leading, spacing: 16){
                TextPreviw
            }
            Spacer()
            VStack(spacing: 10){
                ButtonCellLearnMore
                ButtonCellNext
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
        )
        .cornerRadius(10)
        .padding()
    }
}

#Preview {
    LocationPrewiewView(location: Mocks.port1)
}


extension LocationPrewiewView{
    private var TextPreviw: some View{
        VStack(alignment: .leading, spacing: 6){
            Text(location.name)
                .font(.title)
            Text(location.country)
                .font(.headline)
        }
    }
    
    private var ButtonCellLearnMore: some View{
        Button {
            
        } label: {
            Text("Read more")
                .font(.headline)
                .frame(width:125, height: 35)
        }
        .buttonStyle(.borderedProminent)
        
    }
    
    private var ButtonCellNext: some View{
        Button {
            vm.nextButtonPressed()
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width:125, height: 35)
        }
        .buttonStyle(.bordered)
    }
}
