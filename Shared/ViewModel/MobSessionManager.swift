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
    
    func addMember(named name: String) {
        let memberToAdd = TeamMember(name: name, role: .researcher)
        session.teamMembers.append(memberToAdd)
    }
    
    func delete(at offsets: IndexSet) {
        session.teamMembers.remove(atOffsets: offsets)
    }
    
    func delete(teamMember: TeamMember) {
        session.teamMembers.removeAll { $0.id == teamMember.id }
    }
}
