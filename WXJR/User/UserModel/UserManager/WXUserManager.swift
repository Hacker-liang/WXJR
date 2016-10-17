//
//  WXUserManager.swift
//  WXJR
//
//  Created by liangpengshuai on 8/31/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXUserManager: NSObject {
    
    /**
     获取用户的投资列表
     
     - parameter userId:
     - parameter page:
     - parameter pageSize:
     - parameter completionBlock:
     */
    class func loadUserInvestList(userId: String, page: Int, pageSize: Int, completionBlock:(isSuccess: Bool, investList:[WXInvestModel]?) -> ()) {
        let url = "\(baseUrl)user/\(userId)/invest/list/\(page)/\(pageSize)"

        let set = NSMutableSet()
        set.addObject("FINISHED")
        set.addObject("PROPOSED")
        set.addObject("FROZEN")
        set.addObject("SETTLED")
        set.addObject("OVERDUE")
        set.addObject("BREACH")
        set.addObject("CLEARED")

        let params = ["status": set]
        
        WXNetworkingAPI.GET(url, params: params) { (retObject, error) in
            
            if let retData = retObject as? NSDictionary {
                if let investList = retData.objectForKey("results") as? NSArray {
                    var retList = [WXInvestModel]()
                    for dic in investList {
                        let investModel = WXInvestModel(json: dic as! NSDictionary)
                        retList.append(investModel)
                    }
                    completionBlock(isSuccess: true, investList: retList)
                } else {
                    completionBlock(isSuccess: false, investList: nil)

                }

            } else {
                completionBlock(isSuccess: false, investList: nil)
            }
            
        }
    }
    
    
    class func loadUserFundRecordList(userId: String, page: Int, pageSize: Int, completionBlock:(isSuccess: Bool, fundRecordList:[WXUserFundRecordModel]?) -> ()) {
        let url = "\(baseUrl)user/\(userId)/funds"
        
        let dateLong = Int(NSDate().timeIntervalSince1970*1000)

        let params = ["allOperation": "true",
                      "allStatus": "false",
                      "type": "ALL",
                      "page": page,
                      "pageSize": pageSize,
                      "startDate": 1442592000000,
                      "endDate": dateLong
                      ]
        
        WXNetworkingAPI.GET(url, params: params as [NSObject : AnyObject]) { (retObject, error) in
            
            if let retData = retObject as? NSDictionary {
                if let investList = retData.objectForKey("results") as? NSArray {
                    var retList = [WXUserFundRecordModel]()
                    for dic in investList {
                        let fundModel = WXUserFundRecordModel(json: dic as! NSDictionary)
                        retList.append(fundModel)
                    }
                    completionBlock(isSuccess: true, fundRecordList: retList)
                } else {
                    completionBlock(isSuccess: false, fundRecordList: nil)
                    
                }
                
            } else {
                completionBlock(isSuccess: false, fundRecordList: nil)
            }
        }
    }
    
    /**
     获取用户的银行卡列表
     
     - parameter userId:
     - parameter completionBlock:
     */
    class func loadUserBankInfoList(userId: String, completionBlock:(isSuccess: Bool, bankInfoList:[WXUserBankInfo]?) -> ()) {
        let url = "\(baseUrl)user/\(userId)/fundaccounts"
        
        WXNetworkingAPI.GET(url, params: nil) { (retObject, error) in
            if let retData = retObject as? NSArray {
                var retList = [WXUserBankInfo]()
                for dic in retData {
                    let bankInfo = WXUserBankInfo(json: dic as! NSDictionary)
                    retList.append(bankInfo)
                }
                completionBlock(isSuccess: true, bankInfoList: retList)
            } else {
                completionBlock(isSuccess: false, bankInfoList: nil)
            }
        }
    }
    
    /**
     获取用户的奖券列表
     
     - parameter userId:
     - parameter type:
     - parameter page:
     - parameter pageSize:
     - parameter completionBlock: 
     */
    class func loadUserCouponList(userId: String, type:String, page:Int, pageSize:Int, completionBlock:(isSuccess: Bool, couponsList:[WXUserCouponModel]?) -> ()) {
        let url = "\(baseUrl)coupon/\(userId)/coupons"
        let params = ["type": type]
        WXNetworkingAPI.POST(url, params: params) { (retObject, error) in
            if let retData = retObject as? NSDictionary {
                if let results = retData.objectForKey("data") as? NSDictionary {
                    var retList = [WXUserCouponModel]()
                    for dic in (results.objectForKey("results") as! NSArray) {
                        let coupon = WXUserCouponModel(json: dic as! NSDictionary)
                        retList.append(coupon)
                    }
                    completionBlock(isSuccess: true, couponsList: retList)
                    
                } else {
                    completionBlock(isSuccess: false, couponsList: nil)

                }
                
            } else {
                completionBlock(isSuccess: false, couponsList: nil)
            }
        }
    }
    
    class func loadUserCouponList(userId: String, userMonths:Int, page:Int, pageSize:Int, completionBlock:(isSuccess: Bool, couponsList:[WXUserCouponModel]?) -> ()) {
        let url = "\(baseUrl)coupon/\(userId)/listCoupon"
        let params = ["months": userMonths]
        WXNetworkingAPI.POST(url, params: params) { (retObject, error) in
            if let retData = retObject as? NSDictionary {
                if let results = retData.objectForKey("data") as? NSArray {
                    var retList = [WXUserCouponModel]()
                    for dic in results {
                        let coupon = WXUserCouponModel(json: ((dic as! NSDictionary).objectForKey("placement") as! NSDictionary))
                        retList.append(coupon)
                    }
                    completionBlock(isSuccess: true, couponsList: retList)
                    
                } else {
                    completionBlock(isSuccess: false, couponsList: nil)
                    
                }
                
            } else {
                completionBlock(isSuccess: false, couponsList: nil)
            }
        }
    }
    
    /**
     获取用户的资金托管账户信息
     
     - parameter userId:
     - parameter completionBlock: 
     */
    class func loadUserFundsTrusteeshipAccount(userId: String, completionBlock: (isSuccess:Bool, accountInfo: WXUserTrusteeshipDetail?) -> ()) {
        let url = "\(baseUrl)user/\(userId)/payment"
        
        WXNetworkingAPI.GET(url, params: nil) { (retObject, error) in
            if let retData = retObject as? NSDictionary {
                let account = WXUserTrusteeshipDetail(json: retData)
                completionBlock(isSuccess: true, accountInfo: account)

            } else {
                completionBlock(isSuccess: false, accountInfo: nil)
            }
        }

    }
    
    
    class func userRecharge(userId: String, amount: Int, completionBlock: (isSuccess: Bool, rechargeInfo: NSDictionary?) -> ()) {
        let url = "\(baseUrl)payment/deposit/express/request"
        
        WXNetworkingAPI.POST(url, params: ["amount": amount, "userId": userId, "bank": "", "cardId": "", "express": true, "payType": 1]) { (retObject, error) in
            if let retData = retObject as? NSDictionary {
                if let successDic = retData.objectForKey("data") as? NSDictionary {
                    completionBlock(isSuccess: true, rechargeInfo: successDic)
                } else {
                    completionBlock(isSuccess: false, rechargeInfo: nil)

                }
            } else {
                completionBlock(isSuccess: false, rechargeInfo: nil)
            }
        }
    }

    class func userWithdraw(userId: String, amount: Double, bankAccount: NSString, type: NSString, completionBlock: (isSuccess: Bool, withdrawInfo: NSDictionary?) -> ()) {
        let url = "\(baseUrl)payment/withdraw/request"
        
        let params = ["userId": userId, "withdraw": amount, "account": bankAccount, "cashChl": type, "payType": 1, "express": true];
        WXNetworkingAPI.POST(url, params: params) { (retObject, error) in
            if let retData = retObject as? NSDictionary {
                if let successDic = retData.objectForKey("data") as? NSDictionary {
                    completionBlock(isSuccess: true, withdrawInfo: successDic)
                } else {
                    completionBlock(isSuccess: false, withdrawInfo: nil)
                    
                }
            } else {
                completionBlock(isSuccess: false, withdrawInfo: nil)
            }
        }
    }
    
    class func userGroupIsExist(groupCode: String, completionBlock:(isExist: Bool) -> ()) {
        let url = "\(baseUrl)users/groupExist"
        
        let params = ["groupCode": groupCode]
        WXNetworkingAPI.GET(url, params: params) { (retObject, error) in
            if let retData = retObject as? NSDictionary {
                if let success = retData.objectForKey("success") as? Bool {
                    completionBlock(isExist: success)
                } else {
                    completionBlock(isExist: false)
                }
            } else {
                completionBlock(isExist: false)
            }
        }
    }
    
    class func userResetPassword(loginName: String, tel: String, completionBlock:(isSuccess: Bool) -> ()) {
        let url = "\(baseUrl)resetPassword"
        
        let params = ["newPassword": loginName, "mobile": tel]
        WXNetworkingAPI.POST(url, params: params) { (retObject, error) in
            if let retData = retObject as? NSDictionary {
                if let success = retData.objectForKey("success") as? Bool {
                    completionBlock(isSuccess: success)
                } else {
                    completionBlock(isSuccess: false)
                }
            } else {
                completionBlock(isSuccess: false)
            }
        }
    }
}





