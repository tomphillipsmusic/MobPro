//
//  MobSession.swift
//  MobPro
//
//  Created by Tom Phillips on 7/7/22.
//

import Foundation

struct MobSession {
    var numberOfRotationsBetweenBreaks: Int = 5
    var teamMembers: [TeamMember] = sampleTeam
    var isActive = false    
}

struct TeamMember: Identifiable {
    let id = UUID()
    var name: String
    var role: Role
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
