
//  AppDelegate.swift
//  GZZS
//
//  Created by LiuHao on 2017/9/5.
//  Copyright © 2017年 云南省国有资本运营商城管理有限公司. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder,UIApplicationDelegate,WXApiDelegate,UNUserNotificationCenterDelegate,BMKGeneralDelegate {

    var window: UIWindow?
    var payStatus = Bool()  //用来判断微信支付状态
    var errCode = String()
    var _mapManager: BMKMapManager?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        #if DEBUG
            if((UserDefaults.standard.object(forKey: "host")) == nil){
                UserDefaults.standard.set("TestApi", forKey: "host")
            }
        #else
        #endif
        
        _mapManager = BMKMapManager()
        if BMKMapManager.setCoordinateTypeUsedInBaiduMapSDK(BMK_COORDTYPE_BD09LL) {
            NSLog("经纬度类型设置成功");
        }else{
            NSLog("经纬度类型设置失败");
        }
        // 如果要关注网络及授权验证事件，请设定generalDelegate参数
        let ret = _mapManager?.start("eBqieM9Me62aucMUGYNvDaKOuMnolm7a", generalDelegate: self)
        if ret == false {
            NSLog("manager start failed!")
        }
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = WelcomeViewController()
        
        let manger :QMProfileManager = QMProfileManager.sharedInstance()
        manger.loadProfile("8014@yngznb", password: "gzzs8014")
        
        self.umengTrack()
        UMessage.start(withAppkey: "599d12e58630f52fdc000101", launchOptions: launchOptions, httpsEnable: true)
        UMessage.openDebugMode(true)
        UMessage.registerForRemoteNotifications()

        return true
    }
    
    func umengTrack() {
        MobClick.setAppVersion("")
        MobClick.setLogEnabled(true)
        UMAnalyticsConfig.sharedInstance().appKey = "599d12e58630f52fdc000101"
        MobClick.start(withConfigure:UMAnalyticsConfig.sharedInstance())
        let version:NSString = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! NSString
        print(version)
    
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        UMessage.registerDeviceToken(deviceToken)
        
        let device = NSData(data: deviceToken)
        let deviceId = device.description.replacingOccurrences(of:"<", with:"").replacingOccurrences(of:">", with:"").replacingOccurrences(of:" ", with:"")
        let user = UserDefaults.standard
        user.set(deviceId, forKey: "deviceToken")
        print(deviceId)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        UMessage.didReceiveRemoteNotification(userInfo)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        let error_str :NSString = error as! NSString
        print(error_str)
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
        
        if !payStatus {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "weixinPay"), object: "未知状态")
        }
        payStatus = false
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }
    
    func onResp(_ resp:BaseResp){
        if resp.isKind(of: PayResp.self) {
            switch resp.errCode {
            case 0:
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "weixinPay"), object: "成功")
                break
            default:
                if resp.errStr == nil{
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "weixinPay"), object: "失败")
                }else{
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "weixinPay"), object: resp.errStr)
                }
                break
            }
        }
    }
    
    //MARK: - BMKGeneralDelegate
    func onGetNetworkState(_ iError: Int32) {
        if (0 == iError) {
            NSLog("联网成功");
        }else{
            NSLog("联网失败，错误代码：Error\(iError)");
        }
    }
    
    func onGetPermissionState(_ iError: Int32) {
        if (0 == iError) {
            NSLog("授权成功");
        }
        else{
            NSLog("授权失败，错误代码：Error\(iError)");
        }
    }

    
}
