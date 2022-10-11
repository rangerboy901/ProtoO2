//
//  HapticManager.swift
//  ProtoO2
//
//  Created by Joseph Wil;liam DeWeese on 10/6/22.
//

import SwiftUI


class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
