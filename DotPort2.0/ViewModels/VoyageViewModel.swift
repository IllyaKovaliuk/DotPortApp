//
//  VoyageViewModel.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 22.02.2026.
//

import Foundation
import MapKit

class VoyageViewModel: ObservableObject {
    @Published var voyages: [VoyageModel] = []
    @Published var voyage_data: [VoyageModel] = [VoyageModel.voyage1 , VoyageModel.voyage2, VoyageModel.voyage3]
    @Published var voyage: VoyageModel = VoyageModel.voyage1
    
    init(){
        
    }
    
    func statusValidate(voyage: VoyageModel, nextStatus: VoyageStatus){
        if nextStatus > voyage.status {
            print("200 Ok")
        } else {
            print("404 Bad")
        }
    }
    
    func takeLong(port: PortModel) -> CLLocationDegrees{
        let longtitude = port.longtitude
        return longtitude
    }
    
    func takeLat(port: PortModel) -> CLLocationDegrees{
        let latitude = port.latitude
        return latitude
    }
    
//    func progressBarCalc(voyage: VoyageModel) -> Double {
//        let allCases = VoyageStatus.allCases
//        
//
//    }
    var progress : Double {
        let allCases = VoyageStatus.allCases
        guard let index = allCases.firstIndex(of: voyage.status) else {
            return 0
        }
        return Double(index + 1) / Double(allCases.count)
    }
    
}
