//
//  Constants.swift
//  WXJR
//
//  Created by liangpengshuai on 9/5/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import Foundation

let APP_THEME_COLOR: UIColor            = UIColorFromRGB(0xF04F46, alpha:1)
let APP_PAGE_COLOR: UIColor             = UIColorFromRGB(0xF5F4EE, alpha:1)

let COLOR_LINE: UIColor                 = UIColorFromRGB(0xe2e2e2, alpha:1)

let COLOR_TEXT_I: UIColor               = UIColorFromRGB(0x323232, alpha:1)
let COLOR_TEXT_II: UIColor              = UIColorFromRGB(0x646464, alpha:1)
let COLOR_TEXT_III: UIColor             = UIColorFromRGB(0x969696, alpha:1)
let COLOR_TEXT_IV: UIColor              = UIColorFromRGB(0xc8c8c8, alpha:1)
let COLOR_TEXT_V: UIColor               = UIColorFromRGB(0xcdcdcd, alpha:1)

let kWindowWidth = UIScreen.mainScreen().bounds.size.width
let kWindowHeight = UIScreen.mainScreen().bounds.size.height

let hostUrl = "http://wrzb.uats.cc/"
let baseUrl = "http://wrzb.uats.cc/api/v2/"

//let hostUrl = "https://www.wxfintech.com/"
//let baseUrl = "https://www.wxfintech.com/api/v2/"

let kLastAccountCacheInfo = "LastAccountCacheInfo"

class Constants {
    
    class func Y_M_D_DateFormatWithLongValue(value: NSTimeInterval) -> String {
        let date = NSDate(timeIntervalSince1970: value/1000)
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = NSTimeZone.systemTimeZone()
        return formatter.stringFromDate(date)
    }
    
    class func Y_M_D_H_M_S_DateFormatWithLongValue(value: NSTimeInterval) -> String {
        let date = NSDate(timeIntervalSince1970: value/1000)
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = NSTimeZone.systemTimeZone()
        return formatter.stringFromDate(date)
    }

    
}

func UIColorFromRGB(rgb: Int, alpha: Float) -> UIColor {
    let red = CGFloat(Float(((rgb>>16) & 0xFF)) / 255.0)
    let green = CGFloat(Float(((rgb>>8) & 0xFF)) / 255.0)
    let blue = CGFloat(Float(((rgb>>0) & 0xFF)) / 255.0)
    let alpha = CGFloat(alpha)
    
    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
}