//
//  LocalNotificationService.swift
//  MobPro (iOS)
//
//  Created by Tom Phillips on 8/15/22.
//

import SwiftUI

class LocalNotificationService {
    static let timerEndNotification = "timerEndNotification"
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge , .sound]) { success, error in
            if success {
                print("Permission Granted!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func scheduleLocalNotification(with title: String, scheduledFor timeInterval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(timeInterval), repeats: false)
        let request = UNNotificationRequest(identifier: Self.timerEndNotification, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelLocalNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [Self.timerEndNotification])
    }
}
