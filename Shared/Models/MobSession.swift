//
//  MobSession.swift
//  MobPro
//
//  Created by Tom Phillips on 7/7/22.
//

import Foundation

struct MobSession {
    var teamMembers: [TeamMember] = sampleTeam
    var isActive = false
    var breakLengthInSeconds = Configuration(value: 5 * 60, maxValue: 60 * 30, isTimeValue: true, label: "Break Length", color: "MobOrange")
    var numberOfRotationsBetweenBreaks = Configuration(value: 5 * 60, maxValue: 10 * 60, isTimeValue: false, label: "Rounds Between Breaks", color: "MobYellowGreen")
}

struct TeamMember: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var role: Role
}

struct Configuration: Identifiable {
    let id = UUID()
    var value: Int
    let maxValue: Int
    let isTimeValue: Bool
    let label: String
    let color: String
    var progress: Double = 0
    var angle: Double
    
    init(value: Int, maxValue: Int, isTimeValue: Bool, label: String, color: String) {
        self.value = value
        self.maxValue = maxValue
        self.isTimeValue = isTimeValue
        self.label = label
        self.color = color
        progress = Double(value) / Double(maxValue)
        angle = Double(progress * Double(360))
    }
}

enum Role {
    case driver
    case navigator
    case researcher
    case sponsor
    case observer
    
    var symbolName: String {
        switch self {
            
        case .driver:
            return "car"
        case .navigator:
            return "globe.europe.africa"
        case .researcher:
            return "text.book.closed"
        case .sponsor:
            return "hands.clap"
        case .observer:
            return "person.3"
        }
    }
}

// MARK: Test Data
extension MobSession {
    static let sampleTeam = [
        TeamMember(name: "Tom", role: .driver),
        TeamMember(name: "Zoe", role: .navigator),
        TeamMember(name: "Tyriq", role: .researcher),
        TeamMember(name: "Arlaya", role: .sponsor)
    ]
}
