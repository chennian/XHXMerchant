//
//  AppDelegate.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/5.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import AVFoundation
import SwiftyJSON
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    fileprivate let avSpeech = AVSpeechSynthesizer()
    var window: UIWindow?
    var _mapManager:BMKMapManager?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        configJupsh(launchOptions: launchOptions)
        //百度地图
        configBaidumap()
        //蒲公英更新
        PgyManager.shared().start(withAppId: PGYer_ID)
        PgyManager.shared().isFeedbackEnabled = false
        PgyUpdateManager.sharedPgy().start(withAppId: PGYer_ID)
        PgyUpdateManager.sharedPgy().checkUpdate();
        
        XKeyChain.set("1", key: "merchant")
        XKeyChain.set("1", key: "flowmeter")
        XKeyChain.set("1", key: "service")
        XKeyChain.set("1", key: "operator")
        XKeyChain.set("1", key: "corporation")
        XKeyChain.set("1", key: "employee")

        XKeyChain.set("0", key: TEMP)//解决死循环
        
        let NotifyOne = NSNotification.Name(rawValue:"TAG")
        NotificationCenter.default.addObserver(self, selector: #selector(setTag(notify:)), name: NotifyOne, object: nil)
        
        let NotifyTwo = NSNotification.Name(rawValue:"DELETE")
        NotificationCenter.default.addObserver(self, selector: #selector(deleteTag(notify:)), name: NotifyTwo, object: nil)
        
        window?.rootViewController = SNMainTabBarController.shared
        self.window?.makeKeyAndVisible()
        return true
    }
    
    @objc func setTag(notify:NSNotification){
        guard let text: String = notify.object as! String? else { return }
        CNLog(text)
        JPUSHService.setTags([text], completion: nil, seq: 0)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func deleteTag(notify:NSNotification){
        guard let text: String = notify.object as! String? else { return }
        CNLog(text)
        JPUSHService.deleteTags([text], completion: nil, seq: 0)
//        NotificationCenter.default.removeObserver(self)
    }
    fileprivate func startTranslattion(_ string:String){
        //1. 创建需要合成的声音类型
        let voice = AVSpeechSynthesisVoice(language: "zh-CN")

        //2. 创建合成的语音类
        let utterance = AVSpeechUtterance(string:string)
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        utterance.voice = voice
        utterance.volume = 1
        utterance.postUtteranceDelay = 0.1
        utterance.pitchMultiplier = 1
        //开始播放
        avSpeech.speak(utterance)
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
    
    
    //*-------------------------------RemoteNotifications--------------------------------*/
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
      
        JPUSHService.handleRemoteNotification(userInfo)
        let aps = userInfo["aps"] as! NSDictionary
        let alert = aps["alert"] as! String
        startTranslattion(alert)
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        JPUSHService.registerDeviceToken(deviceToken)
        let registrationID = JPUSHService.registrationID()
        UserDefaults.standard.set(registrationID, forKey: "registrationID")
        UserDefaults.standard.set(registrationID, forKey: "deviceToken")
        JPUSHService.setAlias(registrationID, callbackSelector: nil, object: nil)
        CNLog("JPUSHService.registrationID=\(JPUSHService.registrationID())")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//
//        let session = AVAudioSession.sharedInstance()
//        try? session.setActive(true)
//        try? session.setCategory(AVAudioSessionCategoryPlayback)
        
        JPUSHService.handleRemoteNotification(userInfo)
        let aps = userInfo["aps"] as! NSDictionary
        let alert = aps["alert"] as! String
        startTranslattion(alert)
        completionHandler(.newData)
    }
    
}
extension AppDelegate:BMKGeneralDelegate{
    
    func configBaidumap() {
        _mapManager = BMKMapManager()
        let ret = _mapManager?.start(AK, generalDelegate: self)
        if ret == false {
            CNLog("manager start failed!")
        }
    }
    func onGetNetworkState(iError: Int32) {
        if (0 == iError) {
            CNLog("联网成功");
        }
        else{
            CNLog("联网失败，错误代码：Error\(iError)");
        }
    }
    func onGetPermissionState(iError: Int32) {
        if (0 == iError) {
            CNLog("授权成功");
        }
        else{
            CNLog("授权失败，错误代码：Error\(iError)");
        }
    }
    
}
/// Jpush
extension AppDelegate:JPUSHRegisterDelegate{
    
    func configJupsh(launchOptions:[UIApplicationLaunchOptionsKey: Any]?) ->Void {
        CNLog((launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] as? NSDictionary))
        
        
        if #available(iOS 10.0, *){
            let entiity = JPUSHRegisterEntity()
            entiity.types = Int(UNAuthorizationOptions.alert.rawValue |
                UNAuthorizationOptions.badge.rawValue |
                UNAuthorizationOptions.sound.rawValue)
            JPUSHService.register(forRemoteNotificationConfig: entiity, delegate: self)
        } else if #available(iOS 8.0, *) {
            
            let types = UIUserNotificationType.badge.rawValue |
                UIUserNotificationType.sound.rawValue |
                UIUserNotificationType.alert.rawValue
            JPUSHService.register(forRemoteNotificationTypes: types, categories: nil)
        }else {
            let type = UIRemoteNotificationType.badge.rawValue |
                UIRemoteNotificationType.sound.rawValue |
                UIRemoteNotificationType.alert.rawValue
            JPUSHService.register(forRemoteNotificationTypes: type, categories: nil)
        }
        
        JPUSHService.setup(withOption: launchOptions,
                           appKey: JPushAppKey,
                           channel: "app store",
                           apsForProduction: true)
    }
    
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        let userInfo = notification.request.content.userInfo
        if (notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))! {
            JPUSHService.handleRemoteNotification(userInfo)
//            CNLog(notification.request.content.body)
//            CNLog(notification.request.content.title)
//            CNLog(notification.request.content.subtitle)
//            CNLog(notification.request.content.userInfo)
//            let aps = userInfo["aps"] as! NSDictionary
//            let alert = aps["alert"] as! String
//            let sound = aps["sound"] as! String
//            print(sound)
//            startTranslattion(alert)
         

        } else {// 本地通知
            
        }
        
        completionHandler(Int(UNAuthorizationOptions.alert.rawValue |
            UNAuthorizationOptions.badge.rawValue |
            UNAuthorizationOptions.sound.rawValue))
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        
        let userInfo = response.notification.request.content.userInfo
        
        if (response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))! {
            JPUSHService.handleRemoteNotification(userInfo)
            let aps = userInfo["aps"] as! NSDictionary
            let alert = aps["alert"] as! String
            startTranslattion(alert)

        } else {// 本地通知
        }
        completionHandler()
    }
    
    
}
