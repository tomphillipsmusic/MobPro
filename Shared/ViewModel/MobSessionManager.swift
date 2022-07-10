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
    @Published var isOnBreak = false
    
    var timerText: String {
        if mobTimer.isTimerRunning {
            return mobTimer.formattedTime
        } else {
            return "START"
        }
    }
}

// MARK: Team Management Logic
extension MobSessionManager {
    
    func shuffleTeam() {
        session.teamMembers.shuffle()
        assignRoles()
    }
    
    func moveTeamMember(from source: IndexSet, to destination: Int) {
        session.teamMembers.move(fromOffsets: source, toOffset: destination)
        assignRoles()
    }
    
    private func setUpNewRotation() {
        if isOnBreak {
            endBreak()
        } else {
            setUpNextRound()
        }
        
        resetTimer()
        let isBreakTime = currentRotationNumber == session.numberOfRotationsBetweenBreaks + 1
        
        if isBreakTime {
            startBreak()
        }
    }
    
    func endBreak() {
        isOnBreak = false
        currentRotationNumber %= session.numberOfRotationsBetweenBreaks
        mobTimer.timeRemaining = mobTimer.rotationLength
    }
    
    func setUpNextRound() {
        currentRotationNumber += 1
        mobTimer.timeRemaining = mobTimer.rotationLength
        shiftTeam()
        assignRoles()
    }
    
    func startBreak() {
        isOnBreak = true
        mobTimer.timeRemaining = session.breakLengthInSeconds
        startTime()
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
