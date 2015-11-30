//
//  CoderPower.h
//  CoderPower
//
//  Created by Dawn on 15/11/30.
//  Copyright © 2015年 Dawn. All rights reserved.
//

#import <AppKit/AppKit.h>

@class CoderPower;

static CoderPower *sharedPlugin;

@interface CoderPower : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, retain, readonly) NSBundle* bundle;
@end