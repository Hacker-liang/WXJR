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

    

}
