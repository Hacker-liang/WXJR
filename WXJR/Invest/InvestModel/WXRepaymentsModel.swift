//
//  WXRepayMentsModel.swift
//  WXJR
//
//  Created by liangpengshuai on 9/18/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXRepaymentsModel: NSObject {
    
    var currentPeriod: Int?             //当前回款期数
    var repayDate: NSDate?              //实际回款日期
    var amountPrincipal: Double?        //应还本金
    var amountInterest: Double?         //应还利息
    var amountOutstanding: Double?      //剩余本息
    var dueDate: NSDate?                //应还款日期

    init(json: NSDictionary) {
        
        currentPeriod = json.objectForKey("currentPeriod") as? Int
        repayDate = json.objectForKey("repayDate") as? NSDate
        amountPrincipal = (json.objectForKey("repayment") as! NSDictionary).objectForKey("amountPrincipal") as? Double
        amountInterest = (json.objectForKey("repayment") as! NSDictionary).objectForKey("amountInterest") as? Double
        amountOutstanding = (json.objectForKey("repayment") as! NSDictionary).objectForKey("amountOutstanding") as? Double
        dueDate = (json.objectForKey("repayment") as! NSDictionary).objectForKey("dueDate") as? NSDate
    }
}


