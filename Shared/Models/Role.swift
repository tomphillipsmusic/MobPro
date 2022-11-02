//
//  Role.swift
//  MobPro
//
//  Created by Tom Phillips on 7/27/22.
//

import Foundation
import SwiftUI

enum Role: String, Codable {
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
    
    var responsibilities: [Responsibility] {
        switch self {
        case .driver:
            return Role.driverResponsibilites
        case .navigator:
            return Role.navigatorResponsibilities
        case .researcher:
            return Role.researcherResponsibilities
        }
    }
    
    var color: Color {
        switch self {
        case .driver:
            return .mobGreen
        case .navigator:
            return .mobYellow
        case .researcher:
            return .mobOrange
        }
    }
}


// MARK: Role Responsibilities
extension Role {
    struct Responsibility {
        let text: String
        let symbol: String
        let color: Color
    }
    
    static let driverResponsibilites = [
        Responsibility(text: "Your job is to helm the keyboard and type the code", symbol: "keyboard.fill", color: .mobGreen),
        Responsibility(text: "You rely on the Navigator to tell you what to code", symbol: "globe.europe.africa", color: .mobYellow),
        Responsibility(text: "You need to trust the Navigator's directions", symbol: "location.circle", color: .mobYellow),
        Responsibility(text: "Only think about the next immediate step", symbol: "list.number", color: .mobRed)
    ]
    
    static let navigatorResponsibilities = [
        Responsibility(text: "You guide the Driver on what to code", symbol: "car", color: .mobGreen),
        Responsibility(text: "Always discuss your thoughts out loud", symbol: "speaker.wave.2.fill", color: .mobYellow),
        Responsibility(text: "Make sure the whole mob undertstands the ideas and approach", symbol: "person.3.fill", color: .mobOrange),
        Responsibility(text: "You do not write any lines of code or touch the keyboard", symbol: "slash.circle", color: .mobRed)
    ]
    
    static let researcherResponsibilities = [
        Responsibility(text: "You listen to the Navigator’s train of thought", symbol: "globe.europe.africa", color: .mobYellow),
        Responsibility(text: "Ask questions to spur discussion amongst the mob", symbol: "person.fill.questionmark", color: .mobOrange),
        Responsibility(text: "Perform research on what needs to be done next", symbol: "text.book.closed", color: .mobOrange),
        Responsibility(text: "Anticipate the needs of the mob", symbol: "person.3.fill", color: .mobRed)
    ]
}
