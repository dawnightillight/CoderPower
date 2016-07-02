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

@interface CDPDot : CALayer
@property (nonatomic, retain) NSColor *color;
@property (nonatomic, assign) CGFloat vx;
@property (nonatomic, assign) CGFloat vy;
@property (nonatomic, assign) CGFloat ax;
@property (nonatomic, assign) CGFloat ay;

-(instancetype) initWithFrame:(NSRect) frameRect dotColor:(NSColor *)dotColor;

@end

@implementation CDPDot

-(instancetype) initWithFrame:(NSRect) frameRect dotColor:(NSColor *)dotColor {
	if ((self = [super init]) != nil) {
		self.frame = frameRect;
		self.masksToBounds = NO;
		[self setNeedsDisplay];
		self.color = dotColor;
		self.vx = 10;
		self.vy = 10;
		self.ax = 0;
		self.ay = 0;
	}
	return self;
}

-(void) drawInContext:(CGContextRef)ctx {
	CGContextAddEllipseInRect(ctx, self.bounds);
	CGContextSetFillColorWithColor(ctx, self.color.CGColor);
	CGContextFillPath(ctx);
	CGContextFlush(ctx);
	[super drawInContext:ctx];
}

-(void) dealloc {
	self.color = nil;
	[super dealloc];
}

@end

@interface CDPBubbleView() <CDPBubleAnimateDelegate>
@property (nonatomic, retain) NSMutableArray<CDPDot *> *dots;
@end

@implementation CDPBubbleView

-(instancetype) initWithFrame:(NSRect)frameRect {
	if ((self = [super initWithFrame:frameRect]) != nil) {
		self.wantsLayer = YES;
		self.dots = [[NSMutableArray<CDPDot *> alloc] init];
		for (int i = 0; i < 10; ++i) {
			CDPDot *dot = [[[CDPDot alloc] initWithFrame:CGRectMake(frameRect.size.width / 2 - 5, 0, 10, 10) dotColor:[NSColor greenColor]] autorelease];
			[self.layer addSublayer:dot];
			[self.dots addObject:dot];
		}

		CVDisplayLinkMgr *mgr = [CVDisplayLinkMgr getInstance];
		[mgr addBubleAnimtateDelegate:self];

		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			[self removeFromSuperview];
			CVDisplayLinkMgr *mgr = [CVDisplayLinkMgr getInstance];
			[mgr deleteBubleAnimtateDelegate:self];
		});
	}
	return self;
}

-(void) animate:(long long) deltaTime {
	for (CDPDot *dot in self.dots) {
		CGFloat newX = dot.position.x + deltaTime * 0.001;
		CGFloat newY = dot.position.y + deltaTime * 0.001;
		dot.position = CGPointMake(newX, newY);
	}
}

-(void) dealloc {
	[self.dots removeAllObjects];
	self.dots = nil;
	[super dealloc];
}

@end
