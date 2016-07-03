//
//  CDPUserInfoManager.h
//  CoderPower
//
//  Created by Dawn on 15/11/30.
//  Copyright © 2015年 Dawn. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef NS_ENUM(NSInteger, CDPUserInfoEffectType) {
//    CDPUserInfoEffectTypeWhite,
//    CDPUserInfoEffectTypeOrange,
//};

@interface CDPUserInfoManager : NSObject

+ (BOOL)isShakeOn;
+ (void)setIsShakeOn:(BOOL)isOn;

@end
