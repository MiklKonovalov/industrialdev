//
//  LocalNotificationsService.swift
//  NavigationNew
//
//  Created by Misha on 20.04.2022.
//

import Foundation
import UIKit
import UserNotifications

class LocalNotificationsService: NSObject, UNUserNotificationCenterDelegate {
    
    func registeForLatestUpdatesIfPossible() {
        registerUpdatesCategory()
        
        let center = UNUserNotificationCenter.current()
        
        
        let content = UNMutableNotificationContent()
        content.title = "Посмотри обновления!"
        content.body = "Твои друзья поделились новыми постами"
        content.sound = .default
        content.badge = 1
        content.categoryIdentifier = "Alarm"
        
        var dateComponents = DateComponents()
        dateComponents.hour = 22
        dateComponents.minute = 53
        
        let calendarNotificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    
        let request = UNNotificationRequest(identifier: "vk", content: content, trigger: calendarNotificationTrigger)
        center.add(request)
    }
    
    func registerUpdatesCategory() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let content = UNMutableNotificationContent()
        content.categoryIdentifier = "updates"
        
        let actionShow = UNNotificationAction(identifier: "vkShowMore", title: "Показать больше", options: .foreground)
        
        let category = UNNotificationCategory(identifier: "Alarm", actions: [actionShow], intentIdentifiers: [], options: [])
        
        center.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            let loginCoordinator = LoginCoordinator(navigationController: UINavigationController())
            loginCoordinator.start()
        case "vkShowMore":
            print("Показать больше информации")
        default:
            break
        }
        completionHandler()
    }
}



