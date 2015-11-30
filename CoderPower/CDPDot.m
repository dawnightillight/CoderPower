//
//  CDPDot.m
//  CoderPower
//
//  Created by Dawn on 15/11/30.
//  Copyright © 2015年 Dawn. All rights reserved.
//

#import "CDPDot.h"
#import "NSNumber+Append.h"
#import "CDPViewAnimation.h"

@interface CDPDot() <NSAnimationDelegate>
{
    CGPoint _center;
    CGFloat _radius;
}
@end

@implementation CDPDot

- (instancetype)initWithCenter:(NSPoint)center radius:(CGFloat)radius
{
    NSRect frame = NSMakeRect(center.x-radius, center.y-radius, radius*2, radius*2);
    self = [super initWithFrame:frame];
    if (self) {
        _center = center;
        _radius = radius;
    }
    return self;
}

- (void)animate
{
    CGFloat x = _center.x + [NSNumber randomBetween:1 and:50]*[NSNumber randomSign];
    CGFloat y = _center.y - [NSNumber randomBetween:1 and:50];
    NSPoint toPoint = NSMakePoint(x, y);
    NSRect frame = NSMakeRect(toPoint.x-_radius, toPoint.y-_radius, _radius*2, _radius*2);
    
    CDPViewAnimation *animation = [[[CDPViewAnimation alloc] initWithDuration:1.0f animationCurve:NSAnimationEaseInOut] autorelease];
    animation.delegate = self;
    animation.targetView = self;
    animation.toAlpha = 0;
    animation.toFrame = frame;
    [animation startAnimation];
}

- (void)animationDidEnd:(NSAnimation *)animation
{
    [self removeFromSuperview];
}

- (void)drawRect:(NSRect)dirtyRect
{
    NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:dirtyRect xRadius:_radius yRadius:_radius];
    [path addClip];
    
    [super drawRect:dirtyRect];
}

@end
