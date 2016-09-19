//
//  WXLoanDetailModel.swift
//  WXJR
//
//  Created by liangpengshuai on 9/9/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXLoanDetailModel: NSObject {
    var loanId: String?                 //id
    var title: String?                  //标题
    var amount: Int?                    //总金额
    var balance: Int?                   //项目可投金额
    var rate: Int?                      //年化利率
    var status: WXLoanStatus?           //标的状态
    var statusDesc: String?             //标的状态描述
    var payMethod: LoanPayMethods?      //还款方式
    var payMethodDesc: String?          //还款方式描述
    var duration: Duration?
    var timeOut: Int?
    var timeOpen: NSDate?
    var timeFinished: NSDate?
    var timeSettled: NSDate?
    var timeCleared: NSDate?
    var mortgaged: Bool?
    var bidAmount: Int?
    var bids: Int?
    
    init(json: [String: AnyObject]) {
        super.init()
        loanId = json["id"] as? String
        title = json["title"] as? String
        amount = json["amount"] as? Int
        rate = json["rate"] as? Int
        status = WXLoanStatus(rawValue: (json["status"] as! String))
        switch status! {
        case .kINITIATED:
                statusDesc = "初始"
        case .kSCHEDULED:
            statusDesc = "已安排"
        case .kOPENED:
            statusDesc = "开放投标"
        case .kFAILED:
            statusDesc = "流标"
        case .kFINISHED:
            statusDesc = "已满标"
        case .kCANCELED:
            statusDesc = "已取消"
        case .kSETTLED:
            statusDesc = "已结算"
        case .kCLEARED:
            statusDesc = "已还清"
        case .kOVERDUE:
            statusDesc = "逾期"
        case .kBREACH:
            statusDesc = "违约"
        case .kARCHIVED:
            statusDesc = "已存档"
        }
        
        if let methodStr = json["method"] as? String {
            payMethod = LoanPayMethods(rawValue: methodStr)
        }
        switch payMethod! {
        case .kMonthlyInterest:
            payMethodDesc = "按月付息到期还本"
        case .kEqualInstallment:
            payMethodDesc = "按月等额本息"

        case .kEqualPrincipal:
            payMethodDesc = "按月等额本金"

        case .kBulletRepayment:
            payMethodDesc = "一次性还本付息"

        case .kEqualInterest:
            payMethodDesc = "月平息"
            
        case .kYearlyInterest:
            payMethodDesc = "按年付息到期还本"
        }
        
        duration = Duration()
        duration?.initDuration(json["duration"] as! Dictionary)
        timeOut = json["timeOut"] as? Int
        timeOpen = json["timeOpen"] as? NSDate
        timeFinished = json["timeFinished"] as? NSDate
        timeSettled = json["timeSettled"] as? NSDate
        timeCleared = json["timeCleared"] as? NSDate
        mortgaged = json["mortgaged"] as? Bool
        bidAmount = json["bidAmount"] as? Int
        balance = json["balance"] as? Int
        bids = json["bids"] as? Int
    }
}

struct Duration {
    var years: Int?
    var months: Int?
    var days: Int?
    var totalDays: Int?
    var totalMonths: Int?
    var durationDesc: String?

    mutating func initDuration(json: [String: AnyObject]) {
        years = json["years"] as? Int
        months = json["months"] as? Int
        days = json["days"] as? Int
        totalDays = json["totalDays"] as? Int
        totalMonths = json["totalMonths"] as? Int
        durationDesc = json["showDuration"] as? String
    }
}

enum LoanPayMethods: String {
    case kMonthlyInterest = "MonthlyInterest"
    case kEqualInstallment = "EqualInstallment"
    case kEqualPrincipal = "EqualPrincipal"
    case kBulletRepayment = "BulletRepayment"
    case kEqualInterest = "EqualInterest"
    case kYearlyInterest = "YearlyInterest"
}

enum WXLoanStatus: String {
    
    case kINITIATED = "INITIATED"      //初始
    case kSCHEDULED = "SCHEDULED"      //已安排
    case kOPENED = "OPENED"            //开放投标
    case kFAILED = "FAILED"            //流标
    case kFINISHED = "FINISHED"        //已满标
    case kCANCELED = "CANCELED"        //已取消
    case kSETTLED = "SETTLED"          //已结算
    case kCLEARED = "CLEARED"          //已还清
    case kOVERDUE = "OVERDUE"          //逾期
    case kBREACH = "BREACH"            //违约
    case kARCHIVED = "ARCHIVED"        //已存档
}

