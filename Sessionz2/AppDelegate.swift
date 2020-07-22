//
//  AppDelegate.swift
//  Sessionz2
//
//  Created by Iram Fattah on 3/3/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate  {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        attemptToRegisterForNotifications(application: application)
        return true
    }
    
    func attemptToRegisterForNotifications(application: UIApplication) {
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (authorized, error) in
            if authorized {
                print("Successfully requested notifications")
                
            }
        }
        application.registerForRemoteNotifications()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("DEBUG Registered for notifications with device token", deviceToken)
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Registered with fcm token \(fcmToken)")
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

