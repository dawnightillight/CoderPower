//
//  NSNumber+Append.m
//  CoderPower
//
//  Created by Dawn on 15/11/30.
//  Copyright © 2015年 Dawn. All rights reserved.
//

#import "NSNumber+Append.h"

@implementation NSNumber (Append)

// [begin, end]
+ (NSInteger)randomBetween:(NSInteger)begin and:(NSInteger)end
{
    return (arc4random()%end+begin);
}

+ (CGFloat)randomSign
{
    return (arc4random()%2 == 0 ? -1 : 1);
}

@end
