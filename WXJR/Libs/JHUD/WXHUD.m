//
//  WXHUD.m
//  JHudViewDemo
//
//  Created by liangpengshuai on 10/10/16.
//  Copyright © 2016 晋先森. All rights reserved.
//

#import "WXHUD.h"
#import <Foundation/Foundation.h>

@interface WXHUD()

@property(nonatomic, strong) JHUD *hudView;

@end

@implementation WXHUD

- (void)showHUDInView:(UIView *)view
{
    CGFloat width  = [UIApplication sharedApplication].keyWindow.frame.size.width;
    CGFloat height  = [UIApplication sharedApplication].keyWindow.frame.size.height;
    self.hudView = [[JHUD alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    self.hudView.messageLabel.hidden = YES;
    self.hudView.userInteractionEnabled = NO;
    self.hudView.indicatorBackGroundColor = [UIColor clearColor];
    self.hudView.indicatorForegroundColor = [UIColor orangeColor];
    [self.hudView showAtView:view hudType:JHUDLoadingTypeDot];
}

- (void)hideHUD {
    [self.hudView hide];
}  

@end
