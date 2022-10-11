//
//  WorkoutCellView.swift
//  ProtoO2
//
//  Created by Joseph Wil;liam DeWeese on 10/6/22.
//

import SwiftUI

struct WorkoutCellView: View {
    
    let workout: DailyWorkout
    
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
       
        VStack (alignment:.leading){
           
            HStack {
    
                Text(workout.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .accessibilityAddTraits(.isHeader)
                    .foregroundColor(self.colorize(type: workout.type ))
                    .accessibilityAddTraits(.isHeader)
            }
            Text(workout.objective)
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
                .opacity(1.0)
                .padding(.top, 6)
              
            Spacer()
            HStack{
                Label("\(workout.exercises.count)", systemImage: "target")
                    .accessibilityLabel("\(workout.exercises.count) exercises")
                Spacer()
                Text("\(workout.type)")
       //             .labelStyle(.trailingIcon)
                    .padding(6)
                    .foregroundColor(self.colorize(type: workout.type ))
                    .accessibilityLabel("\(workout.type) Workout type")
                    .font(.caption2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10).stroke(self.colorize(type: workout.type ), lineWidth: 3.0))
                
                
            }
            
        }
        
        
        
       
    //    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)),Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))]), startPoint: .bottom, endPoint: .top))
        
    }
      
}
   

