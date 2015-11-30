//
//  CoderPower.m
//  CoderPower
//
//  Created by Dawn on 15/11/30.
//  Copyright © 2015年 Dawn. All rights reserved.
//

#import "CoderPower.h"
#import "CDPMainMenuItem.h"
#import "CDPUserInfoManager.h"
#import "CDPViewAnimation.h"
#import "NSNumber+Append.h"
#import "CDPDot.h"

#define kAnimationTagShake (233)

@interface CoderPower() <NSAnimationDelegate>
{
    BOOL _isShaking;
}

@property (nonatomic, retain, readwrite) NSBundle *bundle;

@end

@implementation CoderPower

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didApplicationFinishLaunchingNotification:) name:NSApplicationDidFinishLaunchingNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChangeSelection:) name:NSTextViewDidChangeSelectionNotification object:nil];
        
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.bundle = nil;
    [super dealloc];
}

#pragma mark -

- (void)didApplicationFinishLaunchingNotification:(NSNotification*)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
    
    NSMenuItem *editItem = [[NSApp mainMenu] itemWithTitle:@"Edit"];
    if (editItem) {
        [editItem.submenu addItem:[NSMenuItem separatorItem]]; // 分割线
        
        CDPMainMenuItem *mainMenuItem = [CDPMainMenuItem item];
        [editItem.submenu addItem:mainMenuItem];
    }
}

- (void)textViewDidChangeSelection:(NSNotification *)notification
{
    id firstResponder = [[NSApp keyWindow] firstResponder];
    if (![firstResponder isKindOfClass:NSClassFromString(@"DVTSourceTextView")]) return;
    
    [self dealWithTextView:firstResponder];
}

#pragma mark - 

- (void)dealWithTextView:(NSTextView *)textView
{
    if (textView != nil && [CDPUserInfoManager isOn]) {
        NSInteger cursorPoint = [[[textView selectedRanges] objectAtIndex:0] rangeValue].location;
        
        NSUInteger count = 1;
        NSRectArray array = [textView.layoutManager rectArrayForCharacterRange:NSMakeRange(cursorPoint, 0)withinSelectedCharacterRange:NSMakeRange(cursorPoint, 0) inTextContainer:textView.textContainer rectCount:&count];
        NSRect rect = *array;
        CGPoint actionPosition = NSMakePoint(rect.origin.x+rect.size.width, rect.origin.y);
        
        [self hanabiAt:actionPosition view:textView];
        
        // shake
        if ([CDPUserInfoManager isShakeOn]) {
             [self shake];
        }
    }
}

- (void)hanabiAt:(NSPoint)point view:(NSTextView *)view
{
    NSColor *color = [CDPUserInfoManager effectType] == CDPUserInfoEffectTypeWhite ? [NSColor whiteColor] : [NSColor orangeColor];
    for (int i = 0; i < 10; i++) {
        CDPDot *dot = [[CDPDot alloc] initWithCenter:point radius:1];
        dot.backgroundColor = color;
        [view addSubview:dot];
        [dot release];
        [dot animate];
    }
}

- (void)shake
{
    if (_isShaking) {
        return;
    }
    _isShaking = YES;
    
    CGFloat duration = 0.05f;
    CDPViewAnimation *shakeAnimation = [[CDPViewAnimation alloc] initWithDuration:duration animationCurve:NSAnimationEaseInOut];
    shakeAnimation.delegate = self;
    shakeAnimation.targetView = (NSView *)[NSApp keyWindow];
    NSRect frame = shakeAnimation.fromFrame;
    frame.origin.x += [NSNumber randomBetween:1 and:2]*5*[NSNumber randomSign];
    frame.origin.y += [NSNumber randomBetween:1 and:2]*5;
    shakeAnimation.toFrame = frame;
    
    CDPViewAnimation *reverseAnimation = [[CDPViewAnimation alloc] initWithDuration:duration animationCurve:NSAnimationEaseInOut];
    reverseAnimation.delegate = self;
    reverseAnimation.tag = kAnimationTagShake;
    reverseAnimation.targetView = (NSView *)[NSApp keyWindow];
    reverseAnimation.toFrame = reverseAnimation.fromFrame;
    reverseAnimation.fromFrame = frame;
    [reverseAnimation startWhenAnimation:shakeAnimation reachesProgress:1.0f];

    [shakeAnimation startAnimation];
}

#pragma mark -

- (void)animationDidEnd:(NSAnimation *)animation
{
    if ([animation isKindOfClass:[CDPViewAnimation class]]) {
        NSInteger animTag = ((CDPViewAnimation *)animation).tag;
        switch (animTag) {
            case kAnimationTagShake:
            {
                _isShaking = NO;
            }
                break;
            default:
                break;
        }
    }
    [animation autorelease];
}



@end
