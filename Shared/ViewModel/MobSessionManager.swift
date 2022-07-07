//
//  MobSessionManager.swift
//  MobPro
//
//  Created by Tom Phillips on 7/7/22.
//

import Foundation

class MobSessionManager: ObservableObject {
    @Published var session = MobSession()
    @Published var isEditing = false
    @Published var mobTimer = MobTimer()
    @Published var currentRotationNumber = 1
    
    private func assignRoles() {
        for index in 0..<session.teamMembers.count {
            session.teamMembers[index].role = determineRole(for: index)
        }
    }
    
    private func determineRole(for index: Int) -> Role {
        switch index {
        case 0:
            return .driver
        case 1:
            return .navigator
        default:
            return .researcher
        }
    }
    
    func shuffleTeam() {
        session.teamMembers.shuffle()
        assignRoles()
    }

    func shiftTeam() {
        session.teamMembers.shiftInPlace()
    }
}

// CRUD Functions
extension MobSessionManager {
    func addMember(named name: String) {
        let indexOfNewMember = session.teamMembers.count
        let memberToAdd = TeamMember(name: name, role: determineRole(for: indexOfNewMember))
        session.teamMembers.append(memberToAdd)
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

// Timer Logic
extension MobSessionManager {
    
    func startTime() {
        mobTimer.isTimerRunning = true

        mobTimer.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.mobTimer.timeRemaining == 0 {
                self.resetTimer()
                self.currentRotationNumber += 1
            } else {
                self.updateTimeRemaining()
            }
        }
    }

    func resetTimer() {
        mobTimer.isTimerRunning = false
        mobTimer.timer?.invalidate()
        mobTimer.timer = nil
    }
    
    func updateTimeRemaining() {
        mobTimer.timeRemaining -= 1
        mobTimer.minutes = mobTimer.timeRemaining / 60
        mobTimer.seconds = mobTimer.timeRemaining % 60
    }
}
