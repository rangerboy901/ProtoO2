//
//  WorkoutTimerModel.swift
//  ProtoO2
//
//  Created by Joseph William DeWeese on 10/12/22.
//

import Foundation

/// Keeps time for a daily scrum meeting. Keep track of the total meeting time, the time for each speaker, and the name of the current speaker.
class WorkoutTimer: ObservableObject {
    /// A struct to keep track of meeting attendees during a meeting.
    struct Movement: Identifiable {
        /// The attendee name.
        let name: String
        /// True if the attendee has completed their turn to speak.
        var isCompleted: Bool
        /// Id for Identifiable conformance.
        let id = UUID()
    }
    
    /// The name of the meeting attendee who is speaking.
    @Published var activeMovement = ""
    /// The number of seconds since the beginning of the meeting.
    @Published var secondsElapsed = 0
    /// The number of seconds until all attendees have had a turn to speak.
    @Published var secondsRemaining = 0
    /// All meeting attendees, listed in the order they will speak.
    private(set) var movements: [Movement] = []

    /// The scrum meeting length.
    private(set) var timeGoal: Int
    /// A closure that is executed when a new attendee begins speaking.
    var movementChangedAction: (() -> Void)?

    private var timer: Timer?
    private var timerStopped = false
    private var frequency: TimeInterval { 1.0 / 60.0 }
    private var lengthInSeconds: Int { timeGoal * 60 }
    private var secondsPerMovement: Int {
        (timeGoal * 60) / movements.count
    }
    private var secondsElapsedForMovement: Int = 0
    private var movementIndex: Int = 0
    private var movementText: String {
        return "Exercise \(movementIndex + 1): " + movements[movementIndex].name
    }
    private var startDate: Date?
    
    /**
     Initialize a new timer. Initializing a time with no arguments creates a ScrumTimer with no attendees and zero length.
     Use `startScrum()` to start the timer.
     
     - Parameters:
        - lengthInMinutes: The meeting length.
        -  attendees: A list of attendees for the meeting.
     */
    init(timeGoal: Int = 0, exercises: [DailyWorkout.Exercise] = []) {
        self.timeGoal = timeGoal
        self.movements = exercises.movements
        secondsRemaining = lengthInSeconds
        activeMovement = movementText
    }
    
    /// Start the timer.
    func startWorkout() {
        changeToMovement(at: 0)
    }
    
    /// Stop the timer.
    func stopWorkout() {
        timer?.invalidate()
        timer = nil
        timerStopped = true
    }
    
    /// Advance the timer to the next speaker.
    func skipMovement() {
        changeToMovement(at: movementIndex + 1)
    }

    private func changeToMovement(at index: Int) {
        if index > 0 {
            let previousMovementIndex = index - 1
            movements[previousMovementIndex].isCompleted = true
        }
        secondsElapsedForMovement = 0
        guard index < movements.count else { return }
        movementIndex = index
        activeMovement = movementText

        secondsElapsed = index * secondsPerMovement
        secondsRemaining = lengthInSeconds - secondsElapsed
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [weak self] timer in
            if let self = self, let startDate = self.startDate {
                let secondsElapsed = Date().timeIntervalSince1970 - startDate.timeIntervalSince1970
                self.update(secondsElapsed: Int(secondsElapsed))
            }
        }
    }

    private func update(secondsElapsed: Int) {
        secondsElapsedForMovement = secondsElapsed
        self.secondsElapsed = secondsPerMovement * movementIndex + secondsElapsedForMovement
        guard secondsElapsed <= secondsPerMovement else {
            return
        }
        secondsRemaining = max(lengthInSeconds - self.secondsElapsed, 0)

        guard !timerStopped else { return }

        if secondsElapsedForMovement >= secondsPerMovement {
            changeToMovement(at: movementIndex + 1)
            movementChangedAction?()
        }
    }
    
    /**
     Reset the timer with a new meeting length and new attendees.
     
     - Parameters:
         - lengthInMinutes: The meeting length.
         - attendees: The name of each attendee.
     */
    func reset(timeGoal: Int, exercises: [DailyWorkout.Exercise]) {
        self.timeGoal = timeGoal
        self.movements = exercises.movements
        secondsRemaining = lengthInSeconds
        activeMovement = movementText
    }
}

extension DailyWorkout {
    /// A new `WorkoutTimer` using the meeting length and attendees in the `DailyScrum`.
    var timer: WorkoutTimer {
        WorkoutTimer(timeGoal: timeGoal, exercises: exercises)
    }
}

extension Array where Element == DailyWorkout.Exercise {
    var movements: [WorkoutTimer.Movement] {
        if isEmpty {
            return [WorkoutTimer.Movement(name: "Exercise 1", isCompleted: false)]
        } else {
            return map { WorkoutTimer.Movement(name: $0.name, isCompleted: false) }
        }
    }
}
