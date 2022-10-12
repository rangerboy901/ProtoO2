//
//  GeneralWorkoutModel.swift
//  ProtoO2
//
//  Created by Joseph William DeWeese on 10/6/22.
//

import SwiftUI
import Foundation


struct DailyWorkout: Identifiable, Codable {
    let id: UUID
    var title: String
    var objective: String
    var type = ""
    var exercises: [Exercise]
    var timeGoal: Int
    var history: [History] = []
    
    ///initializer that assigns a default value to the id property.
    init(id: UUID = UUID(), title: String, objective: String, type: String, exercises: [String], timeGoal: Int) {
        self.id = id
        self.title = title
        self.objective = objective
        self.type = type
        self.exercises = exercises.map { Exercise(name: $0)}
        self.timeGoal = timeGoal
        
    }
}
extension DailyWorkout {
    
    struct Exercise: Identifiable, Codable {
        var id: UUID
        var name: String
        
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
    ///NESTED DATA
    struct Data {
        var title: String = ""
        var objective: String = ""
        var type: String = "HIIT"
        var exercises: [Exercise] = []
        var timeGoal: Double = 45/////default total time of every workout TODO: create an option for "workout time goal "
       
    }
    
    var data: Data {
        Data(title: title, objective: objective,type: type, exercises: exercises, timeGoal: Double(timeGoal))
    }
    mutating func update(from data: Data) {
           title = data.title
        objective = data.objective
        type = data.type
           exercises = data.exercises
           timeGoal = Int(data.timeGoal)
        
       }
    init(data: Data) {
           id = UUID()
           title = data.title
        objective = data.objective
        type = data.type
           exercises = data.exercises
           timeGoal = Int(data.timeGoal)
          
       }
   }

extension DailyWorkout {
    static var sampleData: [DailyWorkout] {
        [
            DailyWorkout(title: "Dakota", objective: "Complete for Time.", type: "HIIT", exercises: ["Run 1 Mile","100 Push-Ups", "100 Pull-ups", "100 Sit-ups"], timeGoal: 65),
            DailyWorkout(title: "Remington", objective: "Complete for Time.", type: "Power", exercises: ["Run 1 Mile","100 Push-Ups", "100 Pull-ups", "100 Sit-ups"], timeGoal: 120),
            DailyWorkout(title: "Montana", objective: "Complete for Time.", type: "Strength", exercises:[ "Run 1 Mile","100 Push-Ups", "100 Pull-ups", "100 Sit-ups"], timeGoal: 60),
            DailyWorkout(title: "Cooper", objective: "Complete for Time.", type: "Cardio", exercises: ["Run 1 Mile","100 Push-Ups", "100 Pull-ups", "100 Sit-ups"], timeGoal: 45),
        ]
    }
    
    
}
