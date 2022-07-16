//
//  TimerManager.swift
//  MobPro
//
//  Created by Tom Phillips on 7/7/22.
//

import SwiftUI

struct MobTimer {
    var timer: Timer? = nil
    var rotationLength = Configuration(value: 7 * 60, maxValue: 60 * 60, isTimeValue: true, label: "Round Length", color: "MobGreen") {
        didSet {
            timeRemaining = rotationLength.value
        }
    }
    var timeRemaining: Int
    var minutes: Int {
        timeRemaining / 60
    }
    
    var seconds: Int {
        timeRemaining % 60
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
        Double((Double(timeRemaining) / Double(rotationLength.value)) * 360.0)
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
