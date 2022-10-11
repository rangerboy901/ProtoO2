//
//  AddWorkoutScreen.swift
//  ProtoO2
//
//  Created by Joseph William DeWeese on 10/10/22.
//

import SwiftUI



struct AddWorkoutScreen: View {
    //JWD:  PROPERTIES
    @Binding var data: DailyWorkout.Data
    @State private var newExercise = ""
    
    let types = ["HIIT", "Cardio", "Strength", "Power", "Recover", "Stretch"]
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
    
    Form{
        
        Section(header: Text("Workout Details")) {
            
            TextField("Enter workout name...", text: $data.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color(UIColor.tertiarySystemFill))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerSize: .zero).stroke(self.colorize(type: data.type ), lineWidth: 3.0))
                .font(.system(size: 20, weight: .semibold, design: .default))
                .foregroundColor(self.colorize(type: data.type ))
        }
        Section("Workout Description or Objectives") {
            TextEditor(text: $data.objective)
                .frame(width: 350, height: 125, alignment: .leading)
                .multilineTextAlignment(.leading)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(2)
                .background(Color(UIColor.tertiarySystemFill))
                .cornerRadius(10)
                .font(.system(size: 20, weight: .semibold, design: .default))
                .foregroundColor(self.colorize(type: data.type ))
                .accessibilityLabel("\(data.objective)Workout Description")
            ///workout goal slider
        }
        Text("Select a Workout Type:")
        Picker("Workout Type:", selection: $data.type) {
            ForEach(types, id: \.self) {
                Text($0)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .overlay(
            RoundedRectangle(cornerSize: .zero).stroke(self.colorize(type: data.type ), lineWidth: 3.0))
        Section("Time Goal") {
            HStack {
                Slider(value: $data.timeGoal, in:1...180, step: 1){
                    Text("\(Int(data.timeGoal)) minutes.")
                    
                }
                .accessibilityValue("\(Int(data.timeGoal)) minutes")
                
                Text("\(Int(data.timeGoal)) minutes.")
                    .accessibilityHidden(true)
            }
            
        }
        ///EXERCISES
        Section(header: Text("Exercises")) {
            ForEach(data.exercises) { exercise in
                Text(exercise.name)
            }
            .onDelete { indices in
                data.exercises.remove(atOffsets: indices)
            }
            HStack {
                TextField("Enter new exercise...", text: $newExercise)
                Button(action: {
                    HapticManager.notification(type: .success)
                    withAnimation {
                        let exercise = DailyWorkout.Exercise(name: newExercise)
                        data.exercises.append(exercise)
                        newExercise = ""
                    }
                }) {
                    Image(systemName: "plus.circle.fill")
                }
                .disabled(newExercise.isEmpty)
            }
        }
    }
    .navigationTitle("Add Workout")
}
}
struct AddWorkoutScreen_Previews: PreviewProvider {
static var previews: some View {
    AddWorkoutScreen(data: .constant(DailyWorkout.sampleData[0].data))
}
}
