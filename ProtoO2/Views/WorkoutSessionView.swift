//
//  WorkoutSessionView.swift
//  ProtoO2
//
//  Created by Joseph William DeWeese on 10/12/22.
//

import SwiftUI

struct WorkoutSessionView: View {
    @Binding var workout: DailyWorkout
    @StateObject var workoutTimer = WorkoutTimer()
    
    ///Theme rendered by workout type to color
    func colorize(type: String) -> Color {
        switch type {
        case "HIIT":
            return .blue
        case "Strength":
            return .orange
        case "Cardio":
            return .pink
        case "Power":
            return .green
        case "Recover":
            return .indigo
        case "Stretch":
            return .black
        default:
            return .gray
            
        }
    }
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(self.colorize(type: workout.type ))
            VStack {
                WorkoutSessionHeaderView(secondsElapsed: workoutTimer.secondsElapsed, secondsRemaining: workoutTimer.secondsRemaining)
                Circle()
                    .strokeBorder(lineWidth: 24, antialiased: true)
                WorkoutSessionFooterView(movements: workoutTimer.movements, skipAction: workoutTimer.skipMovement)
                
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Seconds Elapsed")
                            .font(.caption)
                        Label("300", systemImage: "hourglass.bottomhalf.fill")
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Seconds Remaining")
                            .font(.caption)
                        Label("600", systemImage: "hourglass.tophalf.fill")
                    }
                }
                .padding()
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Time remaining")
                .accessibilityValue("10 minutes")
                Circle()
                    .strokeBorder(lineWidth: 24, antialiased: true)
                HStack {
                    Text("Exercise 1 of 3")
                    Spacer()
                    Button(action: {}) {
                        Image(systemName:"forward.fill")
                    }
                    .accessibilityLabel("Next exercise")
                }
            }
        }
        .padding()
        .foregroundColor(self.colorize(type: workout.type ))
        .onAppear {
            workoutTimer.reset(timeGoal: workout.timeGoal, exercises: workout.exercises)
            workoutTimer.movementChangedAction = {
            }
            workoutTimer.startWorkout()
        }
        .onDisappear {
            workoutTimer.stopWorkout()
            let newHistory = History(exercises: workout.exercises, objective: workout.objective, timeGoal: workout.timer.secondsElapsed / 60)
            workout.history.insert(newHistory, at: 0)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct WorkoutSessionView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutSessionView(workout: .constant(DailyWorkout.sampleData[0]))
    }
}
