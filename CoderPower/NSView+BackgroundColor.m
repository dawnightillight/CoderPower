//
//  NSView+BackgroundColor.m
//  CoderPower
//
//  Created by Dawn on 15/11/30.
//  Copyright © 2015年 Dawn. All rights reserved.
//

#import "NSView+BackgroundColor.h"
#import <objc/runtime.h>

#define kCDPViewBackgroundColorKey @"kCDPViewBackgroundColorKey"

@implementation NSView (BackgroundColor)

- (NSColor *)backgroundColor
{
    return objc_getAssociatedObject(self, kCDPViewBackgroundColorKey);
}

- (void)setBackgroundColor:(NSColor *)backgroundColor
{
    objc_setAssociatedObject(self, kCDPViewBackgroundColorKey, backgroundColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)drawRect:(NSRect)dirtyRect
{
    NSColor *backgroundColor = [self backgroundColor];
    if (backgroundColor) {
        [backgroundColor set];
        NSRectFill(dirtyRect);
    }
}

@end
