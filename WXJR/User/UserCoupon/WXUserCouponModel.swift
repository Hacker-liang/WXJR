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
    var name: String?
    var dispayName: String?
    var desc: String?
    var totalCount: Int?    //发行总张数
    var timeStart: Int?     //开始时间
    var timeExpire: Int?    //过期时间
    var status: String?     //状态
    var durationRule: String?   //投资时间限制
    var friendlyParValue: String?   //具体额度描述
    var parValue: Int?          //具体额度 1.对于现金券，表示其兑换现金的额度.对于增值券，表示其可以虚拟的本金量.对于加息券，表示其提高利息的基点数（万分之一，参考rate）.对于返现券，表示满足投资要求后平台直接返现的金额.
    
    init(json: NSDictionary) {
        id = json.objectForKey("id") as? String
        type = json.objectForKey("type") as? String
        name = json.objectForKey("name") as? String
        dispayName = json.objectForKey("dispayName") as? String
        desc = json.objectForKey("desc") as? String
        totalCount = json.objectForKey("totalCount") as? Int
        timeStart = json.objectForKey("timeStart") as? Int
        timeExpire = json.objectForKey("timeExpire") as? Int
        status = json.objectForKey("status") as? String
        durationRule = json.objectForKey("durationRule") as? String
        friendlyParValue = json.objectForKey("friendlyParValue") as? String
        parValue = json.objectForKey("parValue") as? Int
    }

}
