//
//  CDPBubbleView.m
//  CoderPower
//
//  Created by tyzual on 7/1/16.
//  Copyright © 2016 Dawn. All rights reserved.
//

#import "CDPBubbleView.h"

#import <Quartz/Quartz.h>

#import "CVDisplayLinkMgr.h"
#import "CDPBubleAnimateDelegate.h"

@interface CDPDot : CALayer
@property (nonatomic, retain) NSColor *color;
@property (nonatomic, retain) NSDate *generateDate;
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
		self.generateDate = [NSDate date];
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
		
		CVDisplayLinkMgr *mgr = [CVDisplayLinkMgr getInstance];
		[mgr addBubleAnimtateDelegate:self];
	}
	return self;
}

-(void) animate:(long long) deltaTime {
	NSArray<CDPDot *> *dotsCopy = nil;
	@synchronized (self.dots) {
		dotsCopy = [self.dots copy];
	}
	for (CDPDot *dot in dotsCopy) {
		NSDate *now = [NSDate date];
		NSTimeInterval lifeTime = [now timeIntervalSinceDate:dot.generateDate];
		static const NSTimeInterval animationDur = 1;
		if (lifeTime > animationDur) {
			[dot removeFromSuperlayer];
			@synchronized (self.dots) {
				[self.dots removeObject:dot];
			}
		}
		[CATransaction begin];
		[CATransaction setDisableActions: YES];
		CGFloat newX = dot.position.x + deltaTime * 0.001;
		CGFloat newY = dot.position.y + deltaTime * 0.001;
		dot.position = CGPointMake(newX, newY);
		dot.opacity = 1.0 - lifeTime * 1.0 / animationDur;
		[CATransaction commit];
	}
	[dotsCopy release];
}

-(void) addBubbleAtPoint:(CGPoint) point {
	@synchronized (self.dots) {
		for (int i = 0; i < 10; ++i) {
			CDPDot *dot = [[[CDPDot alloc] initWithFrame:CGRectMake(0, 0, 10, 10) dotColor:[NSColor greenColor]] autorelease];
			dot.position = CGPointMake(point.x, self.frame.size.height - point.y);
			[self.layer addSublayer:dot];
			[self.dots addObject:dot];
		}
	}
}

-(void) dealloc {
	@synchronized (self.dots) {
		[self.dots removeAllObjects];
		self.dots = nil;
	}
	[super dealloc];
}

@end
