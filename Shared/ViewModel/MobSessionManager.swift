//
//  MobSessionManager.swift
//  MobPro
//
//  Created by Tom Phillips on 7/7/22.
//

import Foundation
import UserNotifications

class MobSessionManager: ObservableObject {
    @Published var session = MobSession()
    @Published var mobTimer = MobTimer()
    @Published var isEditing = false
    @Published var currentRotationNumber = 1
    @Published var isOnBreak = false
    @Published var movedToBackgroundDate: Date?
    @Published var isKeyboardPresented = false
    @Published var localNotificationService = LocalNotificationService()

    var numberOfRoundsBeforeBreak: Int {
        session.numberOfRotationsBetweenBreaks.value / 60
    }
    
    var timerText: String {
        let shouldShowTime = mobTimer.isTimerRunning ||
        mobTimer.timeRemaining < mobTimer.rotationLength.value
        
        if shouldShowTime {
            return mobTimer.formattedTime
        } else {
            return "START"
        }
    }
    
    var isTeamValid: Bool {
        session.teamMembers.count >= Constants.minimumNumberOfMobbers
    }
}

// MARK: Team Management Logic
extension MobSessionManager {
    
    func endSession() {
        currentRotationNumber = 1
        mobTimer.timer = nil
        mobTimer.timeRemaining = mobTimer.rotationLength.value
        isOnBreak = false
        isEditing = false
        session.teamMembers = []
    }
    
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
        
        HapticsManager.shared.timerEnd()
        resetTimer()
        let isBreakTime = currentRotationNumber == numberOfRoundsBeforeBreak + 1
        
        if isBreakTime {
            startBreak()
        }
    }
    
    private func endBreak() {
        isOnBreak = false
        currentRotationNumber = 1
        mobTimer.timeRemaining = mobTimer.rotationLength.value
        mobTimer.rotationLength.value = mobTimer.rotationLength.value
    }
    
    private func setUpNextRound() {
        currentRotationNumber += 1
        mobTimer.timeRemaining = mobTimer.rotationLength.value
        shiftTeam()
        assignRoles()
    }
    
    private func startBreak() {
        isOnBreak = true
        mobTimer.timeRemaining = session.breakLengthInSeconds.value
        mobTimer.rotationLength.value = session.breakLengthInSeconds.value
        startTimer()
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
        
        if mobTimer.isTimerRunning && !isTeamValid {
            resetTimer()
            localNotificationService.cancelLocalNotification()
        }
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
            localNotificationService.cancelLocalNotification()
        } else {
            startTimer()
            scheduleLocalNotification()
        }
    }
    
    private func startTimer() {
        if mobTimer.timer == nil {
            mobTimer.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if self.mobTimer.timeRemaining == 0 {
                    self.setUpNewRotation()
                } else {
                    self.mobTimer.timeRemaining -= 1
                }
            }
        }
    }

    private func resetTimer() {
        mobTimer.timer?.invalidate()
        mobTimer.timer = nil
    }
}

// MARK: Timer End Notification
extension MobSessionManager {

    func movedToBackground() {
        print("Moving to the background")
        
        if mobTimer.isTimerRunning {
            movedToBackgroundDate = Date()
            resetTimer()
        }
    }
    
    func movingToForeGround() {
        print("Moving to the foreground")
        if let movedToBackgroundDate = movedToBackgroundDate {
            let timerHasStarted = mobTimer.timeRemaining < mobTimer.rotationLength.value
            
            if timerHasStarted {
                let deltaTime = Int(Date().timeIntervalSince(movedToBackgroundDate))
                
                mobTimer.timeRemaining = mobTimer.timeRemaining - deltaTime < 0 ? 0 : mobTimer.timeRemaining - deltaTime
                startTimer()
                self.movedToBackgroundDate = nil
            }
        }
        
        HapticsManager.shared.prepareHaptics()
    }
    
    func applicationTerminating() {
        print("App terminating")
        localNotificationService.cancelLocalNotification()
    }
    
    func scheduleLocalNotification() {
        let title = "\(isOnBreak ? "Break" : "Round") has ended."
        let timeInterval = Double(mobTimer.rotationLength.value)
        localNotificationService.scheduleLocalNotification(with: title, scheduledFor: timeInterval)
    }
}
