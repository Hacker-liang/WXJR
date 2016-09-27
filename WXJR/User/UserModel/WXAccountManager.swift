//
//  WXAccountManager.swift
//  WXJR
//
//  Created by liangpengshuai on 9/14/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

let accountManager = WXAccountManager()

class WXAccountManager: NSObject {
    
    var accountDetail: WXAccountModel?
    
    //返回一个单例对象
    class func shareInstance() -> WXAccountManager {
        return accountManager
    }
    
    override init() {
        let userDefault = NSUserDefaults.standardUserDefaults()
        if let userInfo = userDefault.objectForKey(kLastAccountCacheInfo) as? NSDictionary {
            self.accountDetail = WXAccountModel(json: userInfo)
        }
    }
    
    func userIsLoginIn() -> Bool {
        return accountDetail != nil
    }
    
    func userLogin(nickName: String, password: String, completionBlock:(isSuccess: Bool, errorStr: String?) -> ()) {
        let url = "\(hostUrl)ajaxLogin"
        let params = ["loginName": nickName,
                      "password": password,
//                      "grant_type": "password",
//                      "client_id": "client-id-for-mobile-dev",
//                      "client_secret": "client-secret-for-mobile-dev",
                      ]
        WXNetworkingAPI.POST(url, params: params) { (responseObject, error) in
            if let obj = responseObject as? NSDictionary {
                if (obj.objectForKey("success") as! Bool) {
                    self.accountDetail = WXAccountModel(json: obj)
                    
                    let tempDic = obj.mutableCopy()
                    for key in obj.allKeys {
                        if (obj.objectForKey(key)!.isMemberOfClass(NSNull)) {
                            tempDic.setValue("", forKey: key as! String)

                        }
                    }
                    let userDic = (obj.objectForKey("user") as! NSDictionary).mutableCopy()
                    for key in userDic.allKeys {
                        if (userDic.objectForKey(key)!.isMemberOfClass(NSNull)) {
                            userDic.setValue("", forKey: key as! String)
                        }
                    }
                    tempDic.setValue(userDic, forKey: "user")
                    print("temp: \(tempDic)")
                    let userDefault = NSUserDefaults.standardUserDefaults()
                    userDefault.setObject(tempDic, forKey: kLastAccountCacheInfo)
                    userDefault.synchronize()
                    completionBlock(isSuccess: true, errorStr: nil)
                    
                } else {
                    completionBlock(isSuccess: false, errorStr: nil)
                }
            } else {
                completionBlock(isSuccess: false, errorStr: nil)
            }
        }
    }
    
    func userLogout(completionBlock: (isSuccess: Bool)->()) {
        self.accountDetail = nil
        completionBlock(isSuccess: true)
    }
    
    func updateUserFundDate(completionBlock: (isSuccess: Bool)->()) {
        if let account = self.accountDetail {
            let url = "\(baseUrl)user/\(account.userId)/userfund"
            WXNetworkingAPI.GET(url, params: nil) { (responseObject, error) in
                if let objc = responseObject as? NSDictionary {
                    let fundModel = WXUserFundDetail(json: objc)
                    self.accountDetail?.userFundDetail = fundModel
                    completionBlock(isSuccess: true)
                } else {
                    completionBlock(isSuccess: false)
                }
            }
        }
    }
    
    func updateUserInvestDate(completionBlock: (isSuccess: Bool)->()) {
        if let account = self.accountDetail {
            let url = "\(baseUrl)user/\(account.userId)/statistics/invest"
            WXNetworkingAPI.GET(url, params: nil) { (responseObject, error) in
                if let objc = responseObject as? NSDictionary {
                    let investModel = WXUserInvestDetail(json: objc)
                    self.accountDetail?.userInvestDetail = investModel
                    completionBlock(isSuccess: true)
                } else {
                    completionBlock(isSuccess: false)
                }
            }
        }
        
    }
}
