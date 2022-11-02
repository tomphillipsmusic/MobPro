//
//  LocalNotificationService.swift
//  MobPro (iOS)
//
//  Created by Tom Phillips on 8/15/22.
//

import UserNotifications

class LocalNotificationService: NSObject {
    static let timerEndCategoryId = "timerEndCategory"
    static let startNextRoundActionId = "\(Notification.Name.timerEndNotification.rawValue).startNextRound"
    
    override init() {
        super.init()
        configureTimerEndNotificationAction()
        UNUserNotificationCenter.current().delegate = self
    }
    
    private func configureTimerEndNotificationAction() {
        let startNextRound = UNNotificationAction(identifier: Self.startNextRoundActionId, title: "Start Next Round", options: [.foreground])
        let timerEndCategory = UNNotificationCategory(identifier: Self.timerEndCategoryId, actions: [startNextRound], intentIdentifiers: [])
        UNUserNotificationCenter.current().setNotificationCategories([timerEndCategory])
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
    
    func scheduleLocalNotification(with title: String, scheduledIn timeInterval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.sound = .default
        content.categoryIdentifier = Self.timerEndCategoryId
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(timeInterval), repeats: false)
        let request = UNNotificationRequest(identifier: Notification.Name.timerEndNotification.rawValue, content: content, trigger: trigger)
                
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelLocalNotification(withIdentifier identifier: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
    
    func removeDeliveredNotifications() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
    func cancelTimerEndNotification() {
        cancelLocalNotification(withIdentifier: Notification.Name.timerEndNotification.rawValue)
    }
}

//MARK: Notification.Name extension
extension Notification.Name {
    static let timerEndNotification = Notification.Name("timerEndNotification")
}

//MARK: UNUserNotificationCenterDelegate
extension LocalNotificationService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case Self.startNextRoundActionId:
            NotificationCenter.default.post(name: .timerEndNotification, object: response.notification.request.content)
        default:
            break
        }
        completionHandler()
    }
}
