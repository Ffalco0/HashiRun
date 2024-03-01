//
//  Motion.swift
//  HashiRun
//
//  Created by Fabio Falco on 01/03/24.
//

import Foundation
import CoreMotion

class PedometerManager: ObservableObject {
    private let pedometer = CMPedometer()
    @Published var steps = 0
    @Published var distanceInKilometers = 0.0
    @Published var paceInMinutesPerKilometer = 0.0

    func startPedometerUpdates() {
        if CMPedometer.isStepCountingAvailable(),
           CMPedometer.isDistanceAvailable(),
           CMPedometer.isPaceAvailable() { // Check if pace information is available
            pedometer.startUpdates(from: Date()) { [weak self] (data, error) in
                DispatchQueue.main.async {
                    if let pedometerData = data {
                        self?.updatePedometerData(pedometerData)
                    } else if let error = error {
                        print("Pedometer updates error: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    private func updatePedometerData(_ data: CMPedometerData) {
        if let numberOfSteps = data.numberOfSteps as? Int {
            self.steps = numberOfSteps
        }
        
        if let distance = data.distance?.doubleValue {
            self.distanceInKilometers = distance / 1000.0 // Convert distance from meters to kilometers
        }
        
        if let currentPace = data.currentPace?.doubleValue {
            // Convert pace from seconds/meter to minutes/kilometer
            let paceInMinutesPerMeter = currentPace / 60.0
            self.paceInMinutesPerKilometer = paceInMinutesPerMeter * 1000.0
        }
    }
}
