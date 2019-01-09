//
//  AppDelegate.swift
//  Todoie
//
//  Created by Thomas Prezioso on 12/5/18.
//  Copyright © 2018 Thomas Prezioso. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound, .badge]) { (permissionGranted, error) in
            print(error as Any)
        }
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
        let content = UNMutableNotificationContent()
        content.title = "Notification Title"
        content.sound = UNNotificationSound.default
        content.body = "Notification Body"
  
        let date = Date(timeIntervalSinceNow: 3600)
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

        let request = UNNotificationRequest(identifier: "notification-identifier", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
}

