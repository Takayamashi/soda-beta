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
import AWSCognito
import AWSSNS


//リモート通知受け取りメソッド(iOS10以上)
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // iOS 10 以降では通知を受け取るとこちらのデリゲートメソッドが呼ばれる。
    //foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("notification is \(notification)")
        //write your action here
        completionHandler(UNNotificationPresentationOptions.alert)
    }
    
    //background
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        print("response is \(response)")
        //write your action here
        completionHandler()
    }
}




@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var display: CGSize?
    var noteimage: UIImage?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        display = UIScreen.main.bounds.size
        
        
        // Override point for customization after application launch.
        let image = UIImage(named: "back")?.withRenderingMode(.alwaysOriginal)
        UINavigationBar.appearance().backIndicatorImage = image
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = image
        self.createMenuView()
        
        
        // ユーザからPush Notification通知の許可をもらう
        if #available(iOS 10.0, *) {
            // iOS 10 以降の設定
            UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {granted, error in
                    if error != nil {
                        // エラー時の処理
                        return
                    }
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
            })
            
        } else {
            // iOS 10 より前の設定
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
            UIApplication.shared.registerForRemoteNotifications()
            
        }
       
        
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Call the 'activate' method to log an app event for use
        // in analytics and advertising reporting.
        
        if UIApplication.shared.applicationIconBadgeNumber == 0 {
            let noteimage = UIImage(named: "notification20")
        }else{
            let noteimage = UIImage(named: "notification_exist")
        }
        
        
        
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
    
    
    //リモート通知の設定
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //Tokenの文字成形
        var token = String(format: "%@", deviceToken as CVarArg) as String
        let characterSet: CharacterSet = CharacterSet.init(charactersIn: "<>")
        token = token.trimmingCharacters(in: characterSet)
        token = token.replacingOccurrences(of: " ", with: "")
        print("deviceToken: \(token)")
        
        // Initialize the Amazon Cognito credentials provider
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType:.APNortheast1,
                                                                identityPoolId:"ap-northeast-1:fb7c4468-c5e2-40b4-9965-73008613c77e")
        let configuration = AWSServiceConfiguration(region:.APNortheast1, credentialsProvider:credentialsProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        let sns = AWSSNS.default()
        let request = AWSSNSCreatePlatformEndpointInput()
        request?.token = token
        request?.platformApplicationArn = "arn:aws:sns:ap-northeast-1:072606849928:app/APNS_SANDBOX/soda"
        request?.customUserData = "Notification"
        
        sns.createPlatformEndpoint(request!).continueWith(executor: AWSExecutor.mainThread(), block: { (task: AWSTask!) -> AnyObject? in
            if task.error != nil {
                print("Error: \(String(describing: task.error))")
            } else {
                let result = task.result
                let subscribeInput = AWSSNSSubscribeInput()
                subscribeInput?.topicArn = "arn:aws:sns:ap-northeast-1:072606849928:soda-push1"
                subscribeInput?.endpoint = result?.endpointArn
                subscribeInput?.protocols = "Application"
                sns.subscribe(subscribeInput!)
                
                //self.saveEndpointArn(result.endpointArn)
            }
            
            return nil
        })
    }
    
    
    //iOS9以前の通知メソッド
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        // アプリが起動している間に通知を受け取った場合の処理を行う。
        print("didReceiveRemoteNotification")
        print(userInfo)
        if application.applicationState == .active {
            //write your code here when app is in foreground
            print("get the push notification on foreground")
        } else {
            //write your code here for other state
            print("get the push notification on foreground in other")
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // アプリがバックグラウンド状態の時に通知を受け取った場合の処理を行う。
        print("get the push notification on background")
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // システムへのプッシュ通知の登録が失敗した時の処理を行う。
        print("fail to push notification")
    }
    
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void){
        
        completionHandler(UIBackgroundFetchResult.newData)
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

