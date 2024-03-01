//
//  Calories.swift
//  HashiRun
//
//  Created by Fabio Falco on 01/03/24.
//

import Foundation
import HealthKit


class HealthKitManager: ObservableObject {
    private var healthStore: HKHealthStore?
    @Published var caloriesBurned: Double = 0
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }
    
    func requestAuthorization() {
        guard let healthStore = healthStore else { return }
        
        let read = Set([HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!])
        let write = Set<HKSampleType>()
        
        healthStore.requestAuthorization(toShare: write, read: read) { success, error in
            if success {
                self.fetchCaloriesBurned()
            } else {
                print("HealthKit Authorization Failed: \(String(describing: error))")
            }
        }
    }
    
    func fetchCaloriesBurned() {
        guard let healthStore = healthStore,
              let energyBurnedType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else { return }
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: energyBurnedType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            DispatchQueue.main.async {
                let sum = result?.sumQuantity()?.doubleValue(for: .kilocalorie())
                self.caloriesBurned = sum ?? 0
            }
        }
        
        healthStore.execute(query)
    }
}

/*
struct ContentView: View {
    @StateObject private var healthKitManager = HealthKitManager()

    var body: some View {
        VStack {
            Text("Calories Burned: \(healthKitManager.caloriesBurned, specifier: "%.2f")")
                .padding()
                .onAppear {
                    healthKitManager.requestAuthorization()
                }
        }
    }
}*/
