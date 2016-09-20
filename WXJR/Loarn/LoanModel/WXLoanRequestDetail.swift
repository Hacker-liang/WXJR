//
//  WXLoanRequestDetail.swift
//  WXJR
//
//  Created by liangpengshuai on 9/20/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXLoanRequestDetail: NSObject {

    var title: String?
    var amount: Int?
    var duration: Duration?
    var payMethod: LoanPayMethods?
    var rate: Int?
    var desc: String?
    var status: WXLoanStatus?
    var guaranteeInfo: String?
    var mortgageInfo: String?
    var riskInfo: String?
    
    init(json: NSDictionary) {
        title = json.objectForKey("title") as? String
        amount = json.objectForKey("amount") as? Int
        if let dura = json.objectForKey("duration") as? [String: AnyObject] {
            duration = Duration()
            duration?.initDuration(dura)
        }
        if let methodStr = json["method"] as? String {
            payMethod = LoanPayMethods(rawValue: methodStr)
        }
        rate = json.objectForKey("rate") as? Int
        desc = json.objectForKey("description") as? String
        status = WXLoanStatus(rawValue: (json["status"] as! String))
        guaranteeInfo = json.objectForKey("guaranteeInfo") as? String
        mortgageInfo = json.objectForKey("mortgageInfo") as? String
        riskInfo = json.objectForKey("riskInfo") as? String

    }
}
