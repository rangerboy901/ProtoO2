//
//  WorkoutListScreen.swift
//  ProtoO2
//
//  Created by Joseph William DeWeese on 10/6/22.
//

import SwiftUI

import SwiftUI

struct WorkoutListScreen: View {
    //PROPERTIES
    @Binding var workouts: [DailyWorkout]
    @State var isPresented: Bool = false
    
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
        
        List {
            ForEach($workouts) { $workout in
                NavigationLink(destination:
                                WorkoutDetailScreen(workout: $workout))
                {
                    WorkoutCellView(workout: workout)
                    
                }
                .padding(.all)
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(self.colorize(type: workout.type ), lineWidth: 10.0)).opacity(5.0)
            }
        }
        .navigationTitle("Workouts")
        .toolbar {
            Button(action: {
                isPresented = true
            }) {
                Image(systemName: "plus")
            }
            .accessibilityLabel("New Workout")
            .sheet(isPresented: $isPresented) {
                
                
                NavigationView {
                    WorkoutEditScreen()
                        .navigationBarItems(leading: Button("Dismiss") {
                            isPresented = false
                        }, trailing: Button("Add") {
                            let newWorkout = DailyWorkout(
                               title: newWorkoutData.title,
                               exercises: newWorkoutData.exercises,
                              lengthInMinutes: Int(newWorkoutData.timeGoal),
                               color: newWorkoutData.color
                            )
                            workouts.append(newWorkout)
                            isPresented = false
                        })
                }
            }
            
        }
    }
}


struct WorkoutListScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkoutListScreen(workouts: DailyWorkout.sampleData[DailyWorkout])
        }
    }
}
