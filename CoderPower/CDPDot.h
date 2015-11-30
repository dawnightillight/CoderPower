//
//  CDPDot.h
//  CoderPower
//
//  Created by Dawn on 15/11/30.
//  Copyright © 2015年 Dawn. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSView+BackgroundColor.h"

@interface CDPDot : NSView

- (instancetype)initWithCenter:(NSPoint)center radius:(CGFloat)radius;
- (void)animate;

@end
