//
//  WorkoutListScreen.swift
//  ProtoO2
//
//  Created by Joseph William DeWeese on 10/6/22.
//

import SwiftUI


struct WorkoutListScreen: View {
    //PROPERTIES
    @Binding var workouts: [DailyWorkout]
    @State var isPresented: Bool = false
    @Environment(\.scenePhase) private var scenePhase
    @State private var newWorkoutData = DailyWorkout.Data()
    @State private var isPresentingNewWorkoutView = false
    
    let saveAction: ()->Void
    
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
                .listRowBackground(self.colorize(type: workout.type ))
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
            .sheet(isPresented: $isPresentingNewWorkoutView) {
                
                NavigationView {
                    WorkoutEditScreen(data: $newWorkoutData)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Dismiss") {
                                    isPresentingNewWorkoutView = false
                                    newWorkoutData = DailyWorkout.Data()
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Add") {
                                    let newWorkout = DailyWorkout(data: newWorkoutData)
                                    workouts.append(newWorkout)
                                    isPresentingNewWorkoutView = false
                                    newWorkoutData = DailyWorkout.Data()
                                }
                            }
                        }
                }
            }
            .onChange(of: scenePhase) { phase in
                if phase == .inactive { saveAction() }
            }
        }
        
    }
}
struct WorkoutListScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkoutListScreen(workouts: .constant(DailyWorkout.sampleData), saveAction: {})
        }
    }
}
