//
//  WXUserFundDetail.swift
//  WXJR
//
//  Created by liangpengshuai on 9/14/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXUserFundDetail: NSObject {
    
    var availableAmount: Double?   //可用余额
    var frozenAmount: Double?      //冻结余额
    var dueInAmount: Double?       //待收总额
    var dueOutAmount: Double?      //待还总额
    var depositAmount: Double?     //充值总额
    var withdrawAmount: Double?    //提现总额
    var transferAmount: Double?    //商户给用户的转账收入或者用户给商户的转账支出
    var rechargeAmount: Double?

    init(json: NSDictionary) {
        availableAmount = json.objectForKey("availableAmount") as? Double
        frozenAmount = json.objectForKey("frozenAmount") as? Double
        dueInAmount = json.objectForKey("dueInAmount") as? Double
        dueOutAmount = json.objectForKey("dueOutAmount") as? Double
        depositAmount = json.objectForKey("depositAmount") as? Double
        withdrawAmount = json.objectForKey("withdrawAmount") as? Double
        transferAmount = json.objectForKey("transferAmount") as? Double
        rechargeAmount = json.objectForKey("rechargeAmount") as? Double
    }
}
