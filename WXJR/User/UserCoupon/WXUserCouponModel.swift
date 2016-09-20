//
//  WXUserCouponModel.swift
//  WXJR
//
//  Created by liangpengshuai on 9/19/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXUserCouponModel: NSObject {
    
    var id: String?
    var type: String?       //奖券类型
    var typeDesc: String {
        get {
            switch self.type! {
            case "CASH":
                return "现金券"
            case "INTEREST":
                return "加息券"
            case "PRINCIPAL":
                return "增值券"
            case "REBATE":
                return "返现券"
            default:
                return ""
            }
        }
    }
    var name: String?
    var dispayName: String?
    var desc: String?
    var totalCount: Int?    //发行总张数
    var timeStart: Int?     //开始时间
    var timeExpire: Int?    //过期时间
    var status: String?     //状态
    var statusDesc: String {
        get {
            switch self.status! {
            case "INITIATED":
                return "初始"
            case "ACHIEVE_UP":
                return "已领完"
            case "PLACED":
                return "可使用"
            case "USED":
                return "已使用"
            case "CANCELLED":
                return "已作废"
            case "EXPIRED":
                return "已过期"
            case "REDEEMED":
                return "已兑现"
            default:
                return ""
            }
        }
    }
    var durationRule: String?   //投资时间限制
    var friendlyParValue: String?   //具体额度描述
    var parValue: Int?          //具体额度 1.对于现金券，表示其兑换现金的额度.对于增值券，表示其可以虚拟的本金量.对于加息券，表示其提高利息的基点数（万分之一，参考rate）.对于返现券，表示满足投资要求后平台直接返现的金额.
    
    init(json: NSDictionary) {
        
        let package = json.objectForKey("couponPackage") as! NSDictionary
        id = package.objectForKey("id") as? String
        type = package.objectForKey("type") as? String
        name = package.objectForKey("name") as? String
        dispayName = package.objectForKey("dispayName") as? String
        desc = package.objectForKey("desc") as? String
        totalCount = package.objectForKey("totalCount") as? Int
        timeStart = package.objectForKey("timeStart") as? Int
        timeExpire = package.objectForKey("timeExpire") as? Int
        status = json.objectForKey("status") as? String
        desc = package.objectForKey("description") as? String
        durationRule = package.objectForKey("durationRule") as? String
        friendlyParValue = package.objectForKey("friendlyParValue") as? String
        parValue = package.objectForKey("parValue") as? Int
    }

}
