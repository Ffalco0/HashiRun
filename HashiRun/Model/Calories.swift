//
//  Calories.swift
//  HashiRun
//
//  Created by Fabio Falco on 01/03/24.
//

import HealthKit


class HealthKitManager: ObservableObject {
    private var healthStore: HKHealthStore?
    private var activeEnergyQuery: HKAnchoredObjectQuery?
    private var queryAnchor: HKQueryAnchor?
    @Published var caloriesBurned: Double = 0
    
    init() {
        self.healthStore = HKHealthStore()
    }
    
    
    func requestAuthorization() {
        guard let healthStore = healthStore else { return }
        
        let read = Set([HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!])
        let write = Set<HKSampleType>()
        
        healthStore.requestAuthorization(toShare: write, read: read) { success, error in
            if success {
                self.startSession()
            } else {
                print("HealthKit Authorization Failed: \(String(describing: error))")
            }
        }
    }
    
    func startSession() {
        //self.caloriesBurned = 0 
        startQueryingForCaloriesBurned()
    }
    
    func startQueryingForCaloriesBurned() {
        guard let healthStore = healthStore,
              let energyBurnedType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else {
            return
        }
        
        let now = Date()
        let predicate = HKQuery.predicateForSamples(withStart: now, end: nil, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: energyBurnedType, quantitySamplePredicate: predicate, options: .cumulativeSum) { [weak self] _, result, _ in
            DispatchQueue.main.async {
                let sum = result?.sumQuantity()?.doubleValue(for: .kilocalorie())
                self?.caloriesBurned = sum ?? 0
            }
        }
        
        healthStore.execute(query)
    }
    
    func stopQueryingForCaloriesBurned() {
        guard let healthStore = healthStore, let query = activeEnergyQuery else { return }
        healthStore.stop(query)
        self.activeEnergyQuery = nil
    }

}


