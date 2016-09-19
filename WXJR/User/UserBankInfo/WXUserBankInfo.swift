//
//  WXUserBankInfo.swift
//  WXJR
//
//  Created by liangpengshuai on 9/19/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXUserBankInfo: NSObject {
    var id: String?
    var type: String?
    var typeDesc: String? {
        get {
            if self.type! == "CMBC" {
                return "民生银行"
                
            } else if self.type! == "ICBC" {
                return "工商银行"
                
            } else if self.type! == "BOC" {
                return "中国银行"

            } else if self.type! == "CCB" {
                return "建设银行"

            } else if self.type! == "ABC" {
                return "农业银行"

            } else if self.type! == "BOCOM" {
                return "交通银行"

            } else if self.type! == "CMB" {
                return "招商银行"

            } else if self.type! == "CIB" {
                return "兴业银行"

            } else if self.type! == "CITIC" {
                return "中信银行"

            } else if self.type! == "CEB" {
                return "光大银行"

            } else if self.type! == "PINGAN" {
                return "平安银行"

            } else if self.type! == "HXB" {
                return "华夏银行"

            } else if self.type! == "PSBC" {
                return "邮储银行"

            } else if self.type! == "BCCB" {
                return "北京银行"

            } else if self.type! == "GDB" {
                return "广发银行"

            } else if self.type! == "SPDB" {
                return "浦发银行"

            } else if self.type! == "CZB" {
                return "徽商银行"

            } else if self.type! == "BOS" {
                return "上海银行"
                
            } else if self.type! == "NJCB" {
                return "南京银行"
                
            } else if self.type! == "CBHB" {
                return "渤海银行"
                
            } else if self.type! == "SRCB" {
                return "上海农商行"
                
            } else if self.type! == "WZCB" {
                return "温州银行"
                
            } else if self.type! == "NBB" {
                return "宁波银行"
                
            } else if self.type! == "HKBEA" {
                return "东亚银行"
                
            } else if self.type! == "BOCD" {
                return "成都银行"
                
            } else {
                return ""
            }
        }
    }
    var accountNo: String?
    var valid: Bool?
    var defaultAccount: Bool?
    var deleted: Bool?
    var timeRecorded: Int?
    
    init(json: NSDictionary) {
        id = json.objectForKey("id") as? String
        type = (json.objectForKey("account") as! NSDictionary).objectForKey("bank") as? String
        accountNo = (json.objectForKey("account") as! NSDictionary).objectForKey("account") as? String
        valid = json.objectForKey("valid") as? Bool
        defaultAccount = json.objectForKey("defaultAccount") as? Bool
        deleted = json.objectForKey("deleted") as? Bool
        timeRecorded = json.objectForKey("timeRecorded") as? Int
    }
}
