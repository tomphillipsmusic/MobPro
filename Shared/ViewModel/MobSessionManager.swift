//
//  MobSessionManager.swift
//  MobPro
//
//  Created by Tom Phillips on 7/7/22.
//

import Foundation

class MobSessionManager: ObservableObject {
    @Published var session = MobSession()
    @Published var mobTimer = MobTimer()
    @Published var isEditing = false
    @Published var currentRotationNumber = 1
    
    var timerText: String {
        mobTimer.isTimerRunning ? mobTimer.formattedTime : "START"
    }
}

// MARK: Team Management Logic
extension MobSessionManager {
    
    func shuffleTeam() {
        session.teamMembers.shuffle()
        assignRoles()
    }
    
    private func setUpNewRotation() {
        resetTimer()
        mobTimer.timeRemaining = mobTimer.rotationLength
        currentRotationNumber += 1
        shiftTeam()
        assignRoles()
    }

    private func shiftTeam() {
        session.teamMembers.shiftInPlace()
    }
    
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
}

// MARK: CRUD Functions
extension MobSessionManager {
    func addMember(named name: String) {
        let indexOfNewMember = session.teamMembers.count
        let role = determineRole(for: indexOfNewMember)
        let memberToAdd = TeamMember(name: name, role: role)
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

// MARK: Timer Logic
extension MobSessionManager {
    func timerTapped() {
        if mobTimer.isTimerRunning {
            resetTimer()
        } else {
            startTime()
        }
    }
    
    private func startTime() {
        mobTimer.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.mobTimer.timeRemaining == 0 {
                self.setUpNewRotation()
            } else {
                self.mobTimer.timeRemaining -= 1
            }
        }
    }

    private func resetTimer() {
        mobTimer.timer?.invalidate()
        mobTimer.timer = nil
    }
}
