//
//  WorkoutSessionFooterView.swift
//  ProtoO2
//
//  Created by Joseph William DeWeese on 10/12/22.
//

import SwiftUI

struct WorkoutSessionFooterView: View {
  
        let movements: [WorkoutTimer.Movement]
        var skipAction: ()->Void
        
        var movementNumber: Int? {
            guard let index = movements.firstIndex(where: { !$0.isCompleted }) else { return nil}
            return index + 1
        }
        var isLastMovement: Bool {
            return movements.dropLast().allSatisfy { $0.isCompleted }
        }
        var movementText: String {
            guard let movementNumber = movementNumber else { return "No more exercises" }
            return "Exercise \(movementNumber) of \(movements.count)"
        }
        var body: some View {
            VStack {
                HStack {
                    if isLastMovement {
                        Text("Last Exercise")
                    } else {
                        Text(movementText)
                        Spacer()
                        Button(action: skipAction) {
                            Image(systemName:"forward.fill")
                        }
                        .accessibilityLabel("Next speaker")
                    }
                }
            }
            .padding([.bottom, .horizontal])
        }
    }

struct WorkoutSessionFooterView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutSessionFooterView(movements: DailyWorkout.sampleData[0].exercises.movements, skipAction: {})
            .previewLayout(.sizeThatFits)
    }
}
