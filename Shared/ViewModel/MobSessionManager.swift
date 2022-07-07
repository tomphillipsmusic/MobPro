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
    @Published var timerManager = TimerManager()
    
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
        timerManager.isTimerRunning = true
        timerManager.minutes = timerManager.timeRemaining / 60
        timerManager.seconds = timerManager.timeRemaining % 60

        timerManager.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in

            if self.timerManager.timeRemaining == 0 {
                self.resetTimer()
                
            } else {
                self.updateTimeRemaining()
            }
        }
    }
    
    func resumeTimer() {
        timerManager.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in

            if self.timerManager.timeRemaining == 0 {
                self.resetTimer()
                self.timerManager.timeRemaining = self.timerManager.rotationLength
            } else {
                self.updateTimeRemaining()
            }
        }
    }
    
    func resetTimer() {
        timerManager.isTimerRunning = false
        timerManager.timer?.invalidate()
        timerManager.timer = nil
    }
    
    func updateTimeRemaining() {
        timerManager.timeRemaining -= 1
        timerManager.minutes = timerManager.timeRemaining / 60
        timerManager.seconds = timerManager.timeRemaining % 60
    }
}
