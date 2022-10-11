//
//  WorkoutDetailScreen.swift
//  ProtoO2
//
//  Created by Joseph William DeWeese on 10/6/22.
//


import SwiftUI

struct WorkoutDetailScreen: View {
    //JWD:  PROPERTIES
    @Binding var workout: DailyWorkout
    @State private var isPresentingWorkoutEditScreen = false
    @State private var data = DailyWorkout.Data()
    @State private var newExercise = ""
    
    let types = ["HIIT", "Cardio", "Strength", "Power", "Recover","Stretch"]
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    
    
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
            Section(header: Text("Workout Name:")) {
                Text(workout.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(1)
                    .background(Color(UIColor.tertiarySystemFill))
                    .cornerRadius(10)
                    .font(.system(size: 20, weight: .semibold, design: .default))
                    .foregroundColor(self.colorize(type: workout.type ))
                    .accessibilityLabel("\(workout.title)Workout Name")
                
            }
            Section(header: Text("Workout Description or Objective")) {
                Text(workout.objective)
                
                    .padding(1)
                    .background(Color(UIColor.tertiarySystemFill))
                    .cornerRadius(10)
                    .font(.system(size: 19, weight: .semibold, design: .default))
                    .foregroundColor(self.colorize(type: workout.type ))
                    .accessibilityLabel("\(workout.objective)Workout Description")
                
                Divider()
                
            }
            Section(header: Text("Workout Type:")) {
                Text(workout.type)
                    .padding(1)
                    .background(Color(UIColor.tertiarySystemFill))
                    .cornerRadius(10)
                    .font(.system(size: 20, weight: .semibold, design: .default))
                    .foregroundColor(self.colorize(type: workout.type ))
                    .accessibilityLabel("\(workout.type) Workout type")
                
                HStack {
                    Label("Time Goal:", systemImage: "clock")
                        .foregroundColor(self.colorize(type: workout.type ))
                    Spacer()
                    Text("\(workout.timeGoal) minutes")
                }
                .accessibilityElement(children: .combine)
                
                
            }//: #endOf Section
            Section(header: Text("Exercises:")) {
                ForEach(workout.exercises) { exercise in
                    Label(exercise.name, systemImage: "target")
                }
            }//: #endOf Section
            
            Section {
                NavigationLink(
                    destination:  TimerView()
                ){
                    Label("Begin Workout", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .cornerRadius(10)
                }
                .cornerRadius(10)
                .padding()
            }//: #endOf Section
            .cornerRadius(10)
            .foregroundColor(.primary)
        //    .background()
            
        }//#endOfList
        .navigationTitle(workout.title)
                .toolbar {
                    Button("Edit") {
                        isPresentingWorkoutEditScreen = true
                    }
                }
                .sheet(isPresented: $isPresentingWorkoutEditScreen) {
                    NavigationView {
                        WorkoutEditScreen(data: $data)
                            .navigationTitle(workout.title)
                            .toolbar {
                                                   ToolbarItem(placement: .cancellationAction) {
                                                       Button("Cancel") {
                                                           isPresentingWorkoutEditScreen = false
                                                       }
                                                   }
                                                   ToolbarItem(placement: .confirmationAction) {
                                                       Button("Save") {
                                                           isPresentingWorkoutEditScreen = false
                                                           workout.update(from: $data)
                                                       }
                                                   }
                                               }
                                       }
                                   }
                               }
                           }

struct WorkoutDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkoutDetailScreen(workout: .constant(DailyWorkout.sampleData[0]))
        }
    }
}
