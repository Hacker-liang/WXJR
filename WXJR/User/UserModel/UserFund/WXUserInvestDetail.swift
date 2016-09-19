//
//  WXUserInvestDetail.swift
//  WXJR
//
//  Created by liangpengshuai on 9/14/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXUserInvestDetail: NSObject {
    var investInterestAmount: Double?     //累计总收益
    var uncollectedIncome: Double?        //待收总金额
    var investingInterestAmount: Double?  //预期总收益
    var investingPrincipalAmount: Double? //在投总资产
    
    init(json: NSDictionary) {
        investInterestAmount = json.objectForKey("investInterestAmount") as? Double
        uncollectedIncome = json.objectForKey("uncollectedIncome") as? Double
        investingInterestAmount = json.objectForKey("investingInterestAmount") as? Double
        investingPrincipalAmount = json.objectForKey("investingPrincipalAmount") as? Double
    }
}
