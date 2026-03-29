//
//  PlusViewModel.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 20.03.2026.
//

import Foundation
import SwiftData

class PlusViewModel{
    var voyage: Voyage
//    var ports: [PortModel] = []
       
    init(context: ModelContext, voyage: Voyage? = nil) {
           if let voyage {
               self.voyage = voyage
           } else {
               let newVoyage = Voyage()
               context.insert(newVoyage)
               self.voyage = newVoyage
           }
        
//        let descriptor = FetchDescriptor<PortModel>()
//        self.ports = (try? context.fetch(descriptor)) ?? []
       }
}
