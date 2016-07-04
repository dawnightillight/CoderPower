//
//  CDPUserInfoManager.m
//  CoderPower
//
//  Created by Dawn on 15/11/30.
//  Copyright © 2015年 Dawn. All rights reserved.
//

#import "CDPUserInfoManager.h"

#define kKeyShake @"kKeyShake"
#define kKeyBubble @"kKeyBubble"

@implementation CDPUserInfoManager

+ (BOOL)isShakeOn {
    if (![[NSUserDefaults standardUserDefaults] objectForKey:kKeyShake]) {
        [self setIsShakeOn:YES];
    }
    return [[NSUserDefaults standardUserDefaults] boolForKey:kKeyShake];
}

+ (void)setIsShakeOn:(BOOL)isOn {
    [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kKeyShake];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)isBubbleOn {
	if (![[NSUserDefaults standardUserDefaults] objectForKey:kKeyBubble])
		[self setIsBubbleOn:YES];

	return [[NSUserDefaults standardUserDefaults] boolForKey:kKeyBubble];
}

+ (void)setIsBubbleOn:(BOOL)isOn {
	[[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kKeyBubble];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

@end
