//
//  TrainingSession.swift
//  HashiRun
//
//  Created by Fabio Falco on 04/03/24.
//

import Foundation
import SwiftData

@Model class TrainingSession{
    var steps:Int
    var distance: Double
    var pace: Double
    var date:Date
    
    init(steps: Int, distance: Double, pace: Double, date: Date) {
        self.steps = steps
        self.distance = distance
        self.pace = pace
        self.date = date
    }
}
