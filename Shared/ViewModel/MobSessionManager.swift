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
    @Published var hasPendingEdits = false
    @Published var currentRotationNumber = 1
    @Published var isOnBreak = false
    @Published var showingEndSessionAlert = false
    @Published var movedToBackgroundDate: Date?
    @Published var isKeyboardPresented = false
    @Published var localNotificationService = LocalNotificationService()

    var currentConfigurations: Configurations {
        Configurations(rotationLength: mobTimer.rotationLength, breakLengthInSeconds: session.breakLengthInSeconds, numberOfRotationsBetweenBreaks: session.numberOfRotationsBetweenBreaks)
    }
    
    var numberOfRoundsBeforeBreak: Int {
        session.numberOfRotationsBetweenBreaks.value / 60
    }
    
    var timerText: String {
        let shouldShowTime = mobTimer.isTimerRunning ||
        mobTimer.timeRemaining < mobTimer.rotationLength.value
        
        if shouldShowTime {
            return mobTimer.formattedTime
        }else if isOnBreak {
            return "BREAK"
        } else {
            return "START"
        }
    }
    
    var isTeamValid: Bool {
        session.teamMembers.count >= Constants.minimumNumberOfMobbers
    }
    
    init() {
        if let storedConfigurationsData: Configurations = JSONUtility.read(from: Constants.configurationsPath) {
            mobTimer.rotationLength = storedConfigurationsData.rotationLength
            session.numberOfRotationsBetweenBreaks = storedConfigurationsData.numberOfRotationsBetweenBreaks
            session.breakLengthInSeconds = storedConfigurationsData.breakLengthInSeconds
        }
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
        setDefaultConfigurations()
    }
    
    private func setDefaultConfigurations() {
        mobTimer.rotationLength = Configuration.defaultRotationLength
        session.breakLengthInSeconds = Configuration.defaulBreakLengthInSeconds
        session.numberOfRotationsBetweenBreaks = Configuration.defaultNumberOfRotationsBetweenBreaks
        JSONUtility.write(currentConfigurations, to: Constants.configurationsPath)
        JSONUtility.write(session.teamMembers, to: Constants.teamMemberNamesPath)
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
        isOnBreak = currentRotationNumber == numberOfRoundsBeforeBreak + 1
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
        JSONUtility.write(session.teamMembers, to: Constants.teamMemberNamesPath)
    }
    
    func save(_ updatedConfigurations: Configurations) {
        mobTimer.rotationLength = updatedConfigurations.rotationLength
        session.breakLengthInSeconds = updatedConfigurations.breakLengthInSeconds
        session.numberOfRotationsBetweenBreaks = updatedConfigurations.numberOfRotationsBetweenBreaks
        isEditing = false
        hasPendingEdits = false
        currentRotationNumber = 1
        JSONUtility.write(currentConfigurations, to: Constants.configurationsPath)

    }
    
    func delete(at offsets: IndexSet) {
        session.teamMembers.remove(atOffsets: offsets)
        assignRoles()
        JSONUtility.write(session.teamMembers, to: Constants.teamMemberNamesPath)
        
        if mobTimer.isTimerRunning && !isTeamValid {
            resetTimer()
            localNotificationService.cancelTimerEndNotification()
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
        if isOnBreak {
            startBreak()
            scheduleLocalNotification()
        } else if mobTimer.isTimerRunning {
            resetTimer()
            localNotificationService.cancelTimerEndNotification()
        } else {
            startTimer()
            localNotificationService.removeDeliveredNotifications()
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
        localNotificationService.cancelTimerEndNotification()
    }
    
    func scheduleLocalNotification() {
        let title = "\(isOnBreak ? "Break" : "Round") has ended."
        let timeInterval = Double(mobTimer.rotationLength.value)
        localNotificationService.scheduleLocalNotification(with: title, scheduledIn: timeInterval)
    }
    
    func handleTimerEndNotification() {
        setUpNewRotation()
        timerTapped()
    }
}
