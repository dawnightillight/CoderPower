//
//  CDPViewAnimation.m
//  CoderPower
//
//  Created by Dawn on 15/11/30.
//  Copyright © 2015年 Dawn. All rights reserved.
//

#import "CDPViewAnimation.h"

@implementation CDPViewAnimation

- (instancetype)initWithDuration:(NSTimeInterval)duration animationCurve:(NSAnimationCurve)animationCurve
{
    self = [super initWithDuration:duration animationCurve:animationCurve];
    if (self) {
        self.animationBlockingMode = NSAnimationNonblocking;
    }
    return self;
}

- (void)setTargetView:(NSView *)targetView
{
    [targetView retain];
    [_targetView release];
    _targetView = targetView;
    _toAlpha = _fromAlpha = _targetView.alphaValue;
    _toFrame = _fromFrame = _targetView.frame;
    
}

- (void)setCurrentProgress:(NSAnimationProgress)progress
{
    [super setCurrentProgress:progress];

    if (!_targetView) {
        return;
    }
    
    if (_fromAlpha != _toAlpha &&
        _fromAlpha >=0 && _fromAlpha <= 1.0 && _toAlpha >=0 && _toAlpha <= 1.0) {
        _targetView.alphaValue = (_toAlpha - _fromAlpha)*progress + _fromAlpha;
    }
    if (!NSEqualRects(_fromFrame, _toFrame)) {
        NSRect frame = _fromFrame;
        frame.origin.x += (_toFrame.origin.x - _fromFrame.origin.x)*progress;
        frame.origin.y += (_toFrame.origin.y - _fromFrame.origin.y)*progress;
        _targetView.frame = frame;
    }
}

- (void)dealloc
{
    self.targetView = nil;
    [super dealloc];
}

@end
