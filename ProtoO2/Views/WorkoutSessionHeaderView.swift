//
//  WorkoutSessionHeaderView.swift
//  ProtoO2
//
//  Created by Joseph William DeWeese on 10/12/22.
//

import SwiftUI

struct WorkoutSessionHeaderView: View {
    
    let secondsElapsed: Int
    let secondsRemaining: Int
    
    private var totalSeconds: Int {
        secondsElapsed + secondsRemaining
    }
    private var progress: Double {
        guard totalSeconds > 0 else { return 1 }
        return Double(secondsElapsed) / Double(totalSeconds)
    }
    private var minutesRemaining: Int {
        secondsRemaining / 60
    }
    
    var body: some View {
        VStack {
            ProgressView(value: progress)
              
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    Label("\(secondsElapsed)", systemImage: "hourglass.bottomhalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                        .font(.caption)
                    Label("\(secondsRemaining)", systemImage: "hourglass.tophalf.fill")
                    
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Time remaining")
        .accessibilityValue("\(minutesRemaining) minutes")
    }
}
struct WorkoutSessionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutSessionHeaderView(secondsElapsed: 60, secondsRemaining: 180)
            .previewLayout(.sizeThatFits)
    }
}
