//
//  History.swift
//  ProtoO2
//
//  Created by Joseph William DeWeese on 10/12/22.
//

import Foundation

struct History: Identifiable, Codable {
    let id: UUID
    let date: Date
    let objective: String
    var exercises: [DailyWorkout.Exercise]
    var timeGoal: Int
    
    init(id: UUID = UUID(), date: Date = Date(), exercises: [DailyWorkout.Exercise], objective: String,  timeGoal: Int = 5) {
          self.id = id
          self.date = date
        self.objective = objective
          self.exercises = exercises
          self.timeGoal = timeGoal
      }
  }

