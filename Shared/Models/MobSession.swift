//
//  MobSession.swift
//  MobPro
//
//  Created by Tom Phillips on 7/7/22.
//

import Foundation

struct MobSession {
    var teamMembers: [TeamMember]
    var isActive = false
    var breakLengthInSeconds = Configuration.defaulBreakLengthInSeconds
    var numberOfRotationsBetweenBreaks = Configuration.defaultNumberOfRotationsBetweenBreaks
    
    init() {
        if let teamMemberData: [TeamMember] = JSONUtility.read(from: Constants.teamMemberNamesPath) {
            teamMembers = teamMemberData
        } else {
            teamMembers = []
        }    
    }
    
    var teamDescription: String {
        teamMembers.reduce("") { $0 + $1.description }
    }
}

// MARK: Test Data
extension MobSession {
    static let sampleTeam = [
        TeamMember(name: "Tom", role: .driver),
        TeamMember(name: "Zoe", role: .navigator),
        TeamMember(name: "Tyriq", role: .researcher),
        TeamMember(name: "Arlaya", role: .researcher)
    ]
}
