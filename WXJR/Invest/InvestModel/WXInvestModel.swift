//
//  WXInvestModel.swift
//  WXJR
//
//  Created by liangpengshuai on 9/18/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXInvestModel: NSObject {
    var amount: Int?
    var totalIncome: Double = 0
    var rate: Int?
    var duration: Duration?
    var loan: WXLoanDetailModel!
    var endDate: NSTimeInterval?
    var repaymentsList: [WXRepaymentsModel]!
    
    init(json: NSDictionary) {
        amount = json.objectForKey("amount") as? Int
        rate = json.objectForKey("rate") as? Int
        duration = Duration()
        duration?.initDuration(json["duration"] as! Dictionary)
        if let loanDic = json.objectForKey("loan") as? [String: AnyObject] {
            loan = WXLoanDetailModel(json: loanDic)
        }
        repaymentsList = []
        for dic in (json.objectForKey("repayments") as! NSArray) {
            let repayment = WXRepaymentsModel(json: dic as! NSDictionary)
            repaymentsList.append(repayment)
            totalIncome += repayment.amountInterest!
        }
        endDate = json.objectForKey("endDate") as? NSTimeInterval
    }
}
