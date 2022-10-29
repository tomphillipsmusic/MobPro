//
//  TimerManager.swift
//  MobPro
//
//  Created by Tom Phillips on 7/7/22.
//

import SwiftUI

struct MobTimer {
    var timer: Timer? = nil
    var timeRemaining: Int
    
    var rotationLength = Configuration(value: 6 * Constants.secondsPerMinute, maxValue: 60 * Constants.secondsPerMinute, isTimeValue: true, label: "Round Length", color: "MobGreen") {
        didSet {
            timeRemaining = rotationLength.value
        }
    }
    
    var minutes: Int {
        timeRemaining / Constants.secondsPerMinute
    }
    
    var seconds: Int {
        timeRemaining % Constants.secondsPerMinute
    }
    
    var isTimerRunning: Bool {
        timer != nil
    }
    
    var formattedTime: String {
        "\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
    }
    
    var timerProgress: Double {
        Double(Double(timeRemaining) / Double(rotationLength.value))
    }
    
    var degrees: Double {
        Double((Double(timeRemaining) / Double(rotationLength.value)) * Constants.degreesInACircle)
    }
    
    var color: Color {
        let timeRemaining = Double(timeRemaining)
        let rotationLength = Double(rotationLength.value)
        if timeRemaining >= rotationLength * 0.8 {
            return .mobGreen
        } else if timeRemaining >= rotationLength * 0.6 {
            return .mobYellowGreen
        } else if timeRemaining >= rotationLength * 0.4 {
            return .mobYellow
        } else if timeRemaining >= rotationLength * 0.2 {
            return .mobOrange
        } else {
            return .mobRed
        }
    }
    
    init() {
        timeRemaining = rotationLength.value
    }
}
