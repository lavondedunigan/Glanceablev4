//
//  HealthManager.swift
//  GlancableFitness Watch
//
//  Created by Lavonde Dunigan on 11/22/25.
//
import HealthKit
import Foundation

class HKManager: ObservableObject {
    let health = HKHealthStore()

    @Published var steps: Int = 0
    @Published var energy: Double = 0
    @Published var exercise: Double = 0
    @Published var hr: Int = 0

    private let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
    private let energyType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
    private let exerciseType = HKQuantityType.quantityType(forIdentifier: .appleExerciseTime)!
    private let hrType = HKQuantityType.quantityType(forIdentifier: .heartRate)!

    func requestAccess() {
        let types: Set = [stepType, energyType, exerciseType, hrType]

        health.requestAuthorization(toShare: [], read: types) { success, _ in
            if success { self.refreshAll() }
        }
    }

    func refreshAll() {
        fetchSteps()
        fetchEnergy()
        fetchExercise()
        fetchHeartRate()
    }

    private func fetchSteps() {
        let start = Calendar.current.startOfDay(for: .now)
        let predicate = HKQuery.predicateForSamples(withStart: start, end: .now)

        let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate) { _, stats, _ in
            DispatchQueue.main.async {
                self.steps = Int(stats?.sumQuantity()?.doubleValue(for: .count()) ?? 0)
            }
        }
        health.execute(query)
    }

    private func fetchEnergy() {
        let start = Calendar.current.startOfDay(for: .now)
        let predicate = HKQuery.predicateForSamples(withStart: start, end: .now)

        let query = HKStatisticsQuery(quantityType: energyType, quantitySamplePredicate: predicate) { _, stats, _ in
            DispatchQueue.main.async {
                self.energy = stats?.sumQuantity()?.doubleValue(for: .kilocalorie()) ?? 0
            }
        }
        health.execute(query)
    }

    private func fetchExercise() {
        let start = Calendar.current.startOfDay(for: .now)
        let predicate = HKQuery.predicateForSamples(withStart: start, end: .now)

        let query = HKStatisticsQuery(quantityType: exerciseType, quantitySamplePredicate: predicate) { _, stats, _ in
            DispatchQueue.main.async {
                self.exercise = stats?.sumQuantity()?.doubleValue(for: HKUnit.minute()) ?? 0
            }
        }
        health.execute(query)
    }

    private func fetchHeartRate() {
        let sort = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)

        let query = HKSampleQuery(sampleType: hrType,
                                  predicate: nil,
                                  limit: 1,
                                  sortDescriptors: [sort]) { _, sample, _ in
            guard let hr = sample?.first as? HKQuantitySample else { return }
            DispatchQueue.main.async {
                self.hr = Int(hr.quantity.doubleValue(for: HKUnit(from: "count/min")))
            }
        }
        health.execute(query)
    }
}
