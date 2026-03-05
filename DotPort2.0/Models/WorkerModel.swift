//
//  WorkerModel.swift
//  DotPort2.0
//
//  Created by Illya Kovaliuk on 17.02.2026.
//

import Foundation

enum Positions: String{
    case Docker = "Docker"
    case KranOperator = "Kran operator"
    case Checkers = "Checkers"
    case Captain = "Captain"
    case Worker = "Worker"
    
}

struct WorkerModel: Identifiable {
    var id = UUID()
    var firstName: String
    var lastName: String
    var position: Positions
    var hoursWorked: Float
    var tasksComplete: Int
    var kpiScore: Float
    var isActive: Bool = false
    var hire_date: Date
    let photo: String?
}

let currentDate = Date()

let workerData = [
    WorkerModel(firstName: "Illya", lastName: "Kovaliuk", position: Positions.Captain, hoursWorked: 15.9, tasksComplete: 10, kpiScore: 5.6, hire_date: currentDate, photo: "globe")
]
