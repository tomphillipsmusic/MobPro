//
//  Role.swift
//  MobPro
//
//  Created by Tom Phillips on 7/27/22.
//

import Foundation

enum Role: String {
    case driver = "Driver"
    case navigator = "Navigator"
    case researcher = "Researcher"
    
    var symbolName: String {
        switch self {
            
        case .driver:
            return "car"
        case .navigator:
            return "globe.europe.africa"
        case .researcher:
            return "text.book.closed"
        }
    }
    
    var responsibilities: [String] {
        switch self {
        case .driver:
            return Role.driverResponsibilites
        case .navigator:
            return Role.navigatorResponsibilities
        case .researcher:
            return Role.researcherResponsibilities
        }
    }
}

// MARK: Role Responsibilities
extension Role {
    
    static let driverResponsibilites = [
    "Your job is to helm the keyboard and type the code",
    "You rely on the Navigator to tell you what to code",
    "You need to trust the Navigator's directions",
    "Only think about the next immediate step"
    ]
    
    static let navigatorResponsibilities = [
    "You guide the Driver on what to code",
    "Always discuss your thoughts out loud",
    "Make sure the whole mob undertstands the ideas and approach",
    "You do not write any lines of code or touch the keyboard"
    ]
    
    static let researcherResponsibilities = [
        "You listen to the Navigator’s train of thought",
        "Ask questions to spur discussion amongst the mob",
        "Perform research on what needs to be done next",
        "Anticipate the needs of the mob"
    ]
}
