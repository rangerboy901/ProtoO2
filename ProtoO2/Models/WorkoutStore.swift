//
//  WorkoutStore.swift
//  ProtoO2
//
//  Created by Joseph William DeWeese on 10/12/22.
//

import Foundation
import SwiftUI

class WorkoutStore: ObservableObject {
    @Published var workouts: [DailyWorkout] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("workouts.data")
    }
    
    static func load(completion: @escaping (Result<[DailyWorkout], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let dailyWorkouts = try JSONDecoder().decode([DailyWorkout].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(dailyWorkouts))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func save(workouts: [DailyWorkout], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(workouts)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(workouts.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
