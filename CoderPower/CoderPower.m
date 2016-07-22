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
#import "CDPSparkView.h"
#import "DVTTextStorage.h"

#define kAnimationTagShake (233)

@interface CoderPower() <NSAnimationDelegate>
{
    BOOL _isShaking;
}

@property (nonatomic, retain, readwrite) NSBundle *bundle;
@property (nonatomic, retain) NSMutableDictionary<NSString *, CDPSparkView *> *viewMaps;

@end

@implementation CoderPower

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        self.bundle = plugin;
		self.viewMaps = [[[NSMutableDictionary<NSString *, CDPSparkView *> alloc] init] autorelease];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didApplicationFinishLaunchingNotification:) name:NSApplicationDidFinishLaunchingNotification object:nil];
        
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:NSTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.bundle = nil;
	self.viewMaps = nil;
    [super dealloc];
}

#pragma mark -

- (void)didApplicationFinishLaunchingNotification:(NSNotification*)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];

	NSMenu *mainMenu = [NSApp mainMenu];
	CDPMainMenuItem *CDPItem = [CDPMainMenuItem item];
	[mainMenu insertItem:CDPItem atIndex:7];
}

- (void)textDidChange:(NSNotification *)notification {
	if (!notification)
		return;

	id obj = notification.object;
	if (!obj || ![obj isKindOfClass:[NSTextView class]])
		return;

	//////////////////////////////////////////////////////////////
	// 这段代码的本意是只在代码编辑的view上打字时才有特效
	// 但是目前没有更好的办法判断view是不是代码编辑的view
	// 通过观察发现在所有view中,代码编辑view的maxSize是
	// (10000000.00, 10000000.00),所以暂时用这种方法来
	// 判断
	//////////////////////////////////////////////////////////////
	NSTextView *textView = (NSTextView *)obj;
	NSSize maxSize = textView.maxSize;
	if (!NSEqualSizes(maxSize, NSMakeSize(10000000.00, 10000000.00)))
		return;
	//////////////////////////////////////////////////////////////

	if ([CDPUserInfoManager isShakeOn])
		[self shake];

	if ([CDPUserInfoManager isSparkOn])
		[self spark:textView];
}

#pragma mark - 

- (void)spark:(NSTextView *)textView
{
    if (textView != nil) {
        NSInteger cursorPoint = [[[textView selectedRanges] objectAtIndex:0] rangeValue].location;
        
        NSUInteger count = 1;
        NSRectArray array = [textView.layoutManager rectArrayForCharacterRange:NSMakeRange(cursorPoint, 0)withinSelectedCharacterRange:NSMakeRange(cursorPoint, 0) inTextContainer:textView.textContainer rectCount:&count];
		if (count == 0)
			return;

        NSRect rect = array[0];
        CGPoint actionPosition = NSMakePoint(rect.origin.x, rect.origin.y);
        
        [self hanabiAt:actionPosition view:textView];
    }
}

- (void)hanabiAt:(NSPoint)point view:(NSTextView *)view {
	if (!view.identifier)
		view.identifier = [[NSUUID UUID] UUIDString];

	NSColor *color = [NSColor whiteColor];
	if ([view.textStorage isKindOfClass:NSClassFromString(@"DVTTextStorage")]) {
		DVTTextStorage *storage = (DVTTextStorage *)view.textStorage;
		NSInteger location = view.selectedRange.location;
		NSRange range = NSMakeRange(location, 1);
		location = MAX(location - 1, 0);
		color = [storage colorAtCharacterIndex:location effectiveRange:&range context:nil];
//		NSLog(@"color : %@", color);
	}

	CDPSparkView *sparkView = [self.viewMaps objectForKey:view.identifier];
	if (!sparkView) {
		sparkView = [[CDPSparkView alloc] initWithFrame:view.bounds];
		[view addSubview:sparkView];
		[sparkView release];
		[self.viewMaps setObject:sparkView forKey:view.identifier];
	}

	if (!sparkView.superview)
		[view addSubview:sparkView];

	[sparkView addSparkAtPoint:point color:color];
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
    frame.origin.x += [NSNumber randomBetween:5 and:10] * [NSNumber randomSign];
	frame.origin.y += [NSNumber randomBetween:5 and:10] * [NSNumber randomSign];
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
