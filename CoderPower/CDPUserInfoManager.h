//
//  CDPUserInfoManager.h
//  CoderPower
//
//  Created by Dawn on 15/11/30.
//  Copyright © 2015年 Dawn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDPUserInfoManager : NSObject

+ (BOOL)isShakeOn;
+ (void)setIsShakeOn:(BOOL)isOn;

+ (BOOL)isBubbleOn;
+ (void)setIsBubbleOn:(BOOL)isOn;

@end
