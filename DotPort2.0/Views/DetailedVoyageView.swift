//
//  DetailedVoyageView.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 19.02.2026.
//

import SwiftUI

struct DetailedVoyageView: View {
    @StateObject var viewModel = VoyageViewModel()
//    @State var voyage: VoyageModel
    var body: some View {
        VStack{
            ZStack{
                ScrollView{
                    VStack{
                        HStack{
                            Text("\(viewModel.voyage_data)")
                            Text("")
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    DetailedVoyageView(/*voyage: VoyageViewModel().voyage_data[1]*/)
}

//port: PortsViewModel().ports_data[1]
