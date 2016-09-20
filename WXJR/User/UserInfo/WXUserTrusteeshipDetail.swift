//
//  WXUserTrusteeshipDetail.swift
//  WXJR
//
//  Created by liangpengshuai on 9/20/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXUserTrusteeshipDetail: NSObject {
    var accountId: String?
    var accountName: String?
    var timeCreate: Int?
    
    init(json: NSDictionary) {
        accountId = json.objectForKey("accountId") as? String
        accountName = json.objectForKey("accountName") as? String
        timeCreate = json.objectForKey("timeCreate") as? Int
    }
}
