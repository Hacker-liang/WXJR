//
//  WXAccountModel.swift
//  WXJR
//
//  Created by liangpengshuai on 9/14/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit


class WXAccountModel: WXUserDetail {
    
    var access_token: String?
    var lastLoginDate: Int?
    var registerDate: Int?
    var enabled: Bool?
    var userFundDetail: WXUserFundDetail?
    var userInvestDetail: WXUserInvestDetail?
    
    override init(json: NSDictionary) {
        let user = json.objectForKey("user") as! NSDictionary
        access_token = json.objectForKey("access_token") as? String
        lastLoginDate = user.objectForKey("lastLoginDate") as? Int
        registerDate = user.objectForKey("registerDate") as? Int
        enabled = user.objectForKey("enabled") as? Bool
        super.init(json: user)
    }
    
}
