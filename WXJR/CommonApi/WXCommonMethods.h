//
//  WXCommonMethods.h
//  WXJR
//
//  Created by liangpengshuai on 9/20/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WXCommonMethods : NSObject

+ (NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim;

+ (UIImage*)createImageWithColor: (UIColor*)color;

+ (BOOL)isCorrectPhoneNumber:(NSString *)phone;

@end
