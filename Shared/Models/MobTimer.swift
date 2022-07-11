//
//  TimerManager.swift
//  MobPro
//
//  Created by Tom Phillips on 7/7/22.
//

import Foundation

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
    
    init() {
        timeRemaining = rotationLength.value
    }
}
