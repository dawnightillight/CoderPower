//
//  CDPUserInfoManager.m
//  CoderPower
//
//  Created by Dawn on 15/11/30.
//  Copyright © 2015年 Dawn. All rights reserved.
//

#import "CDPUserInfoManager.h"

#define kKeyShake @"kKeyShake"
#define kKeySpark @"kKeySpark"
#define kClr @"kClr"

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

+ (BOOL)isSparkOn {
	if (![[NSUserDefaults standardUserDefaults] objectForKey:kKeySpark])
		[self setIsSparkOn:YES];

	return [[NSUserDefaults standardUserDefaults] boolForKey:kKeySpark];
}

+ (void)setIsSparkOn:(BOOL)isOn {
	[[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kKeySpark];
	[[NSUserDefaults standardUserDefaults] synchronize];
}


+ (NSInteger)getClr {
	if (![[NSUserDefaults standardUserDefaults] objectForKey:kClr])
		[self setClr:clrCrt];

	return [[NSUserDefaults standardUserDefaults] integerForKey:kClr];
}

+ (void)setClr:(NSInteger)clr {
	[[NSUserDefaults standardUserDefaults] setInteger:clr forKey:kClr];
	[[NSUserDefaults standardUserDefaults] synchronize];
}
@end
