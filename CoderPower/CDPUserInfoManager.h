//
//  CDPUserInfoManager.h
//  CoderPower
//
//  Created by Dawn on 15/11/30.
//  Copyright © 2015年 Dawn. All rights reserved.
//

#import <Foundation/Foundation.h>


#define clrSch 1
#define clrCrt 2

@interface CDPUserInfoManager : NSObject

+ (BOOL)isShakeOn;
+ (void)setIsShakeOn:(BOOL)isOn;

+ (BOOL)isSparkOn;
+ (void)setIsSparkOn:(BOOL)isOn;

+ (NSInteger)getClr;
+ (void)setClr:(NSInteger)clr;

@end
