//
//  LocalNotificationsService.swift
//  NavigationNew
//
//  Created by Misha on 20.04.2022.
//

import Foundation
import UIKit
import UserNotifications

class LocalNotificationsService {

    /*func requestPermission() {
        func setupNotifications(on application: UIApplication) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if granted {
                    print("Notifications valid")
                } else {
                    print("Invalid access")
                }
            }
        }
    }*/
    
    func registeForLatestUpdatesIfPossible() {
        
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Посмотри обновления!"
        content.body = "Твои друзья поделились новыми постами"
        content.sound = .default
        content.badge = 1
        
        var dateComponents = DateComponents()
        dateComponents.hour = 20
        dateComponents.minute = 01
        
        let calendarNotificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    
        let request = UNNotificationRequest(identifier: "vk", content: content, trigger: calendarNotificationTrigger)
        center.add(request)
    }
    
}
