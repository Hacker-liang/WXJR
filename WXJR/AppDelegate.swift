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
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
        if WXAccountManager.shareInstance().userIsLoginIn() {
            WXAccountManager.shareInstance().userSilentLogin()
        }
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }

    

}

