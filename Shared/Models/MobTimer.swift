//
//  TimerManager.swift
//  MobPro
//
//  Created by Tom Phillips on 7/7/22.
//

import Foundation

struct MobTimer {
    var isTimerRunning = false
    var timer: Timer? = nil
    var rotationLength = 30
    var timeRemaining: Int
    var minutes: Int
    var seconds: Int
    var formattedTime: String {
        "\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
    }
    
    init() {
        timeRemaining = rotationLength
        minutes = timeRemaining / 60
        seconds = timeRemaining % 60
    }
    
}
