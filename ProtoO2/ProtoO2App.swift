//
//  ProtoO2App.swift
//  ProtoO2
//
//  Created by Joseph William DeWeese on 10/5/22.
//

import SwiftUI

@main
struct ProtoO2App: App {
//    @State private var workouts = DailyWorkout.sampleData
    @StateObject private var store = WorkoutStore()
    
    var body: some Scene {
        WindowGroup {
                   NavigationView {
                       WorkoutListScreen(workouts: $store.workouts) {
                           WorkoutStore.save(workouts: store.workouts) { result in
                               if case .failure(let error) = result {
                                   fatalError(error.localizedDescription)
                               }
                           }
                       }
                   }
                   .onAppear {
                       WorkoutStore.load { result in
                           switch result {
                           case .failure(let error):
                               fatalError(error.localizedDescription)
                           case .success(let workouts):
                               store.workouts = workouts
                           }
                       }
                   }
               }
           }
       }
