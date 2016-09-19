//
//  WXUserDetail.swift
//  WXJR
//
//  Created by liangpengshuai on 9/14/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXUserDetail: NSObject {
    
    var userId: String!
    var name: String?
    var nickname: String?
    var mobile: String?
    var email: String?
    
    init(json: NSDictionary) {
        userId = json.objectForKey("id") as? String
        name = json.objectForKey("name") as? String
        nickname = json.objectForKey("loginName") as? String
        mobile = json.objectForKey("mobile") as? String
        email = json.objectForKey("email") as? String
    }
}
