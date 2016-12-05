//
//  AppDelegate.swift
//  WXJR
//
//  Created by liangpengshuai on 8/30/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UINavigationBar.appearance().barTintColor = UIColor.whiteColor()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        if WXAccountManager.shareInstance().userIsLoginIn() {
            WXAccountManager.shareInstance().userSilentLogin({ (isSuccess) in
                if !isSuccess {
                    print("登录信息已过期，需要重新登录")

                    WXAccountManager.shareInstance().userLogout({ (isSuccess) in
                        
                    })
                }
            })
            print("静默登录")
        }
        
    }

    func applicationWillTerminate(application: UIApplication) {
        
    }

}

