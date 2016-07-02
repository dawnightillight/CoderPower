//
//  CDPUserInfoManager.m
//  CoderPower
//
//  Created by Dawn on 15/11/30.
//  Copyright © 2015年 Dawn. All rights reserved.
//

#import "CDPUserInfoManager.h"

#define kKeySwitch @"kKeySwitch"
//#define kKeyShake @"kKeyShake"
//#define kKeyBreathLight @"kKeyBreathLight"
//#define kKeyEffect @"kKeyEffect"

@implementation CDPUserInfoManager

+ (BOOL)isOn
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:kKeySwitch]) {
        [self setIsOn:YES];
    }
    return [[NSUserDefaults standardUserDefaults] boolForKey:kKeySwitch];
}

+ (void)setIsOn:(BOOL)isOn
{
    [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kKeySwitch];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//+ (BOOL)isShakeOn
//{
//    if (![[NSUserDefaults standardUserDefaults] objectForKey:kKeyShake]) {
//        [self setIsShakeOn:YES];
//    }
//    return [[NSUserDefaults standardUserDefaults] boolForKey:kKeyShake];
//}
//
//+ (void)setIsShakeOn:(BOOL)isShakeOn
//{
//    [[NSUserDefaults standardUserDefaults] setBool:isShakeOn forKey:kKeyShake];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}

//+ (CDPUserInfoEffectType)effectType
//{
//    if (![[NSUserDefaults standardUserDefaults] objectForKey:kKeyEffect]) {
//        [self setEffectType:CDPUserInfoEffectTypeWhite];
//    }
//    return [[NSUserDefaults standardUserDefaults] integerForKey:kKeyEffect];
//}
//
//+ (void)setEffectType:(CDPUserInfoEffectType)effectType
//{
//    [[NSUserDefaults standardUserDefaults] setInteger:effectType forKey:kKeyEffect];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}

@end
