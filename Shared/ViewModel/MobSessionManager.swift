//
//  MobSessionManager.swift
//  MobPro
//
//  Created by Tom Phillips on 7/7/22.
//

import Foundation

class MobSessionManager: ObservableObject {
    @Published private(set) var session = MobSession()
    @Published var isEditing = false
}

// CRUD Functions
extension MobSessionManager {
    func addMember(named name: String) {
        let indexOfNewMember = session.teamMembers.count
        let memberToAdd = TeamMember(name: name, role: determineRole(for: indexOfNewMember))
        session.teamMembers.append(memberToAdd)
    }
    
    func assignRoles() {
        for index in 0..<session.teamMembers.count {
            session.teamMembers[index].role = determineRole(for: index)
        }
    }
    
    func determineRole(for index: Int) -> Role {
        switch index {
        case 0:
            return .driver
        case 1:
            return .navigator
        default:
            return .researcher
        }
    }
    
    func delete(at offsets: IndexSet) {
        session.teamMembers.remove(atOffsets: offsets)
        assignRoles()
    }
    
    func delete(teamMember: TeamMember) {
        session.teamMembers.removeAll { $0.id == teamMember.id }
        assignRoles()
    }
}
