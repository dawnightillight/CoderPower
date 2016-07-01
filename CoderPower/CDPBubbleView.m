//
//  CDPBubbleView.m
//  CoderPower
//
//  Created by tyzual on 7/1/16.
//  Copyright © 2016 Dawn. All rights reserved.
//

#import "CDPBubbleView.h"

#import "CVDisplayLinkMgr.h"
#import "CDPBubleAnimateDelegate.h"

@interface CDPDotView : NSView
@property (nonatomic, retain) NSColor *color;
@property (nonatomic, assign) CGFloat vx;
@property (nonatomic, assign) CGFloat vy;
@property (nonatomic, assign) CGFloat ax;
@property (nonatomic, assign) CGFloat ay;

-(instancetype) initWithFrame:(NSRect) frameRect dotColor:(NSColor *)dotColor;

@end

@implementation CDPDotView

-(instancetype) initWithFrame:(NSRect) frameRect dotColor:(NSColor *)dotColor {
	if ((self = [super initWithFrame:frameRect]) != nil) {
		self.color = dotColor;
		self.vx = 10;
		self.vy = 10;
		self.ax = 0;
		self.ay = 0;
	}
	return self;
}

-(void) drawRect:(NSRect)dirtyRect {
	[super drawRect:dirtyRect];
	NSGraphicsContext* aContext = [NSGraphicsContext currentContext];
	CGContextRef cgContext = [aContext CGContext];
	CGContextAddEllipseInRect(cgContext, self.bounds);
	CGContextSetFillColorWithColor(cgContext, self.color.CGColor);
	CGContextFillPath(cgContext);
	[aContext flushGraphics];
}

@end

@interface CDPBubbleView() <CDPBubleAnimateDelegate>
@property (nonatomic, retain) NSMutableArray<CDPDotView *> *dots;
@end

@implementation CDPBubbleView

-(instancetype) initWithFrame:(NSRect)frameRect {
	if ((self = [super initWithFrame:frameRect]) != nil) {
		self.dots = [[NSMutableArray<CDPDotView *> alloc] init];
		for (int i = 0; i < 10; ++i) {
			CDPDotView *dot = [[[CDPDotView alloc] initWithFrame:CGRectMake(frameRect.size.width / 2 - 5, 0, 10, 10) dotColor:[NSColor greenColor]] autorelease];
			[self addSubview:dot];
			[self.dots addObject:dot];
		}

		CVDisplayLinkMgr *mgr = [CVDisplayLinkMgr getInstance];
		[mgr addBubleAnimtateDelegate:self];

		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			[self removeFromSuperview];
			CVDisplayLinkMgr *mgr = [CVDisplayLinkMgr getInstance];
			[mgr deleteBubleAnimtateDelegate:self];
			[self release];
		});
	}
	return self;
}

-(void) animate:(long long) deltaTime {
//	dispatch_async(dispatch_get_main_queue(), ^{
		for (CDPDotView *dot in self.dots) {
			CGFloat newX = dot.frame.origin.x + deltaTime * 0.0000001;
			CGFloat newY = dot.frame.origin.y + deltaTime * 0.0000001;
			CGRect newRect = CGRectMake(newX, newY, dot.frame.size.width, dot.frame.size.height);
			dot.frame = newRect;
		}
//	});
}

@end
