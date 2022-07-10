//
//  MobSession.swift
//  MobPro
//
//  Created by Tom Phillips on 7/7/22.
//

import Foundation

struct MobSession {
    var numberOfRotationsBetweenBreaks: Int = 2
    var breakLengthInSeconds: Int = 10
    var teamMembers: [TeamMember] = sampleTeam
    var isActive = false
    var configurations = [
        Configuration(value: 7, maxValue: 60 * 60, isTimeValue: true, label: "Round Length", color: "MobGreen"),
        Configuration(value: 5, maxValue: 10, isTimeValue: false, label: "Time Between Breaks", color: "MobGreenYellow"),
        Configuration(value: 5, maxValue: 60 * 30, isTimeValue: true, label: "Break Length", color: "MobOrange")
    ]
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
    var isTimeValue: Bool
    var label: String
    var color: String
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
