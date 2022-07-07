//
//  TimerManager.swift
//  MobPro
//
//  Created by Tom Phillips on 7/7/22.
//

import Foundation

struct TimerManager {
    var isTimerRunning = false
    var timer: Timer? = nil
    var rotationLength = 30
    var timeRemaining: Int
    var minutes = 0
    var seconds = 0
    var formattedTime: String {
        "\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
    }
    
    init() {
        timeRemaining = rotationLength
    }
    
}
