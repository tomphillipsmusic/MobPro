//
//  LocalNotificationService.swift
//  MobPro (iOS)
//
//  Created by Tom Phillips on 8/15/22.
//

import UserNotifications

class LocalNotificationService: NSObject {
    static let timerEndNotification = "timerEndNotification"
    static let timerEndCategoryId = "timerEndCategory"
    static let startNextRoundActionId = "timerEndNotification.startNextRound"
    let startNextRound: UNNotificationAction
    let timerEndCategory: UNNotificationCategory
    
    override init() {
        startNextRound = UNNotificationAction(identifier: Self.startNextRoundActionId, title: "Start Next Round", options: [.foreground])
        timerEndCategory = UNNotificationCategory(identifier: Self.timerEndCategoryId, actions: [startNextRound], intentIdentifiers: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([timerEndCategory])
        
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
     
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
        content.categoryIdentifier = Self.timerEndCategoryId
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(timeInterval), repeats: false)
        let request = UNNotificationRequest(identifier: Self.timerEndNotification, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelLocalNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [Self.timerEndNotification])
    }
}

extension LocalNotificationService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case Self.startNextRoundActionId:
            // Handle action
            print("Start next round action")
            let notificationName = Notification.Name(response.notification.request.identifier)
            print(notificationName)
            NotificationCenter.default.post(name:notificationName , object: response.notification.request.content)
        default:
            break
        }
        completionHandler()
    }
}
