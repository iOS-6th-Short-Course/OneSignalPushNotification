//
//  AppDelegate.swift
//  OneSignalPushNotification
//
//  Created by Chhaileng Peng on 1/27/19.
//  Copyright © 2019 Chhaileng Peng. All rights reserved.
//

import UIKit
import OneSignal

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, OSSubscriptionObserver {
    
    var window: UIWindow?

    func onOSSubscriptionChanged(_ stateChanges: OSSubscriptionStateChanges!) {
        if !stateChanges.from.subscribed && stateChanges.to.subscribed {
            print("Subscribed for OneSignal push notifications!")
            // get player ID
            print("Player ID: \(stateChanges.to.userId)")
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        OneSignal.add(self as OSSubscriptionObserver)
        
        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false]
        
        
        let notificationOpenHandler: OSHandleNotificationActionBlock = { (result) in
            // This block gets called when the user reacts to a notification received
            let payload: OSNotificationPayload = result!.notification.payload
            
            //Try to fetch the action selected
            if let additionalData = payload.additionalData,
               let message = additionalData["message"] as? String {
//                print("MESSAGE: \(message)")
//                let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                let rootVC = self.window?.rootViewController as! ViewController
//                rootVC.present(alert, animated: true, completion: nil)
            }
            
            if let actionID = result?.action.actionID {
                print("actionID =", actionID)
                if actionID == "999" {
                    let alert = UIAlertController(title: "Detail Button is Clicked", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    let rootVC = self.window?.rootViewController as! ViewController
                    rootVC.present(alert, animated: true, completion: nil)
                }
            }
            
        }
        
        
        // Replace 'YOUR_APP_ID' with your OneSignal App ID.
        OneSignal.initWithLaunchOptions(launchOptions,
                                        appId: "e49685b9-b54f-4620-b33d-4df8c6fb62d1",
                                        handleNotificationAction: notificationOpenHandler,
                                        settings: onesignalInitSettings)
        
        
        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;
        
        // Recommend moving the below line to prompt for push after informing the user about
        //   how your app will use them.
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
        })
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

