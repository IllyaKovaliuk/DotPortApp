//
//  VoyageViewModel.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 22.02.2026.
//

import Foundation

class VoyageViewModel: ObservableObject {
    @Published var voyages: [VoyageModel] = []
    @Published var voyage_data: [VoyageModel] = [VoyageModel.voyage1 , VoyageModel.voyage2, VoyageModel.voyage3]
    
    
}
