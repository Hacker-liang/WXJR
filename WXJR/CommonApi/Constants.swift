//
//  Constants.swift
//  WXJR
//
//  Created by liangpengshuai on 9/5/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import Foundation

let APP_THEME_COLOR: UIColor            = Constants.UIColorFromRGB(0xE83738, alpha:1)
let APP_PAGE_COLOR: UIColor             = Constants.UIColorFromRGB(0xF5F4EE, alpha:1)

let COLOR_LINE: UIColor                 = Constants.UIColorFromRGB(0xe2e2e2, alpha:1)

let COLOR_TEXT_I: UIColor               = Constants.UIColorFromRGB(0x323232, alpha:1)
let COLOR_TEXT_II: UIColor              = Constants.UIColorFromRGB(0x646464, alpha:1)
let COLOR_TEXT_III: UIColor             = Constants.UIColorFromRGB(0x969696, alpha:1)
let COLOR_TEXT_IV: UIColor              = Constants.UIColorFromRGB(0xc8c8c8, alpha:1)
let COLOR_TEXT_V: UIColor               = Constants.UIColorFromRGB(0xcdcdcd, alpha:1)

let kWindowWidth = UIScreen.mainScreen().bounds.size.width
let kWindowHeight = UIScreen.mainScreen().bounds.size.height

class Constants {
    
    class func UIColorFromRGB(rgb: Int, alpha: Float) -> UIColor {
        let red = CGFloat(Float(((rgb>>16) & 0xFF)) / 255.0)
        let green = CGFloat(Float(((rgb>>8) & 0xFF)) / 255.0)
        let blue = CGFloat(Float(((rgb>>0) & 0xFF)) / 255.0)
        let alpha = CGFloat(alpha)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
}