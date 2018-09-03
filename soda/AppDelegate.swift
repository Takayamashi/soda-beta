//
//  AppDelegate.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/05/28.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var display: CGSize?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        display = UIScreen.main.bounds.size
        
        // Override point for customization after application launch.
        let image = UIImage(named: "back")?.withRenderingMode(.alwaysOriginal)
        UINavigationBar.appearance().backIndicatorImage = image
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = image
        self.createMenuView()
       
        
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Call the 'activate' method to log an app event for use
        // in analytics and advertising reporting.
    }
    
    func createMenuView(){
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "Main")
        let leftVC = storyboard.instantiateViewController(withIdentifier: "Left")
        let navigationController = UINavigationController(rootViewController: mainVC)
        let slideMenuController = SlideMenuController(mainViewController: navigationController, leftMenuViewController: leftVC)
        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()
        SlideMenuOptions.contentViewScale = 1.0
        SlideMenuOptions.contentViewDrag = true
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

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

