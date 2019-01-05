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
        
        // first, you declare the content of the notification:
        let content = UNMutableNotificationContent()
        content.title = "Notification Title"
        content.subtitle = "Notification Subtitle"
        content.body = "Notification Body"
        
        // now, you should declare the UNCalendarNotificationTrigger instance,
        // but before that, you'd need to describe what's the date matching for firing it:
        
        // for instance, this means it should get fired every Monday, at 10:30:
        var date = DateComponents()
        date.weekday = 6
        date.hour = 16
        date.minute = 28
        
        // declaring the trigger
        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        // creating a request and add it to the notification center
        let request = UNNotificationRequest(identifier: "notification-identifier", content: content, trigger: calendarTrigger)
        UNUserNotificationCenter.current().add(request)
    }
    
}

