//
//  AppDelegate.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/5.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var _mapManager:BMKMapManager?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        
//        XLocationManager.shareUserInfonManager.startUpLocation()

        //百度地图
        configBaidumap()
        //蒲公英更新
        PgyManager.shared().start(withAppId: PGYer_ID)
        PgyManager.shared().isFeedbackEnabled = false
        PgyUpdateManager.sharedPgy().start(withAppId: PGYer_ID)
        PgyUpdateManager.sharedPgy().checkUpdate();

        XKeyChain.set("0", key: TEMP)

        window?.rootViewController = SNMainTabBarController.shared
        
        self.window?.makeKeyAndVisible()
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
