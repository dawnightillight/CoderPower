//
//  CDPSparkView.m
//  CoderPower
//
//  Created by tyzual on 7/1/16.
//  Copyright © 2016 Dawn. All rights reserved.
//

#import "CDPSparkView.h"

#import <Quartz/Quartz.h>

#import "NSNumber+Append.h"
#import "CVDisplayLinkMgr.h"
#import "CDPBubleAnimateDelegate.h"

@interface CDPDot : CALayer
@property (nonatomic, retain) NSColor *color;
@property (nonatomic, retain) NSDate *generateDate;
@property (nonatomic, assign) CGFloat vx;
@property (nonatomic, assign) CGFloat vy;
@property (nonatomic, assign) CGFloat ax;
@property (nonatomic, assign) CGFloat ay;
@property (nonatomic, assign) NSTimeInterval lifeTime;

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
		NSInteger lifeTime = [NSNumber randomBetween:3 and:7] * 3;
		self.lifeTime = lifeTime / 10.f;
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

@interface CDPSparkView() <CDPBubleAnimateDelegate>
@property (nonatomic, retain) NSMutableArray<CDPDot *> *dots;
@end

@implementation CDPSparkView

-(instancetype) initWithFrame:(NSRect)frameRect {
	if ((self = [super initWithFrame:frameRect]) != nil) {
		self.wantsLayer = YES;
		self.dots = [[NSMutableArray<CDPDot *> alloc] init];
		
		CVDisplayLinkMgr *mgr = [CVDisplayLinkMgr getInstance];
		[mgr addBubleAnimtateDelegate:self];
	}
	return self;
}

-(void) viewDidChangeBackingProperties {
	self.layer.contentsScale = [[self window] backingScaleFactor];
}

-(BOOL) layer:(CALayer *)layer shouldInheritContentsScale:(CGFloat)newScale fromWindow:(NSWindow *)window {
	return YES;
}

-(void) animate:(long long) deltaTime {
	NSArray<CDPDot *> *dotsCopy = nil;
	@synchronized (self.dots) {
		dotsCopy = [self.dots copy];
	}
	deltaTime = deltaTime * 0.0000001;
	for (CDPDot *dot in dotsCopy) {
		NSDate *now = [NSDate date];
		NSTimeInterval lifeTime = [now timeIntervalSinceDate:dot.generateDate];
		NSTimeInterval animationDur = dot.lifeTime;
		if (lifeTime > animationDur) {
			[dot removeFromSuperlayer];
			@synchronized (self.dots) {
				[self.dots removeObject:dot];
				if (self.dots.count == 0)
					[self removeFromSuperview];
			}
		}
		[CATransaction begin];
		[CATransaction setDisableActions: YES];
		dot.vx += deltaTime * dot.ax;
		dot.vy += deltaTime * dot.ay;
		CGFloat sX = dot.vx * deltaTime + 1.0f / 2 * dot.ax * deltaTime * deltaTime;
		CGFloat sy = dot.vy * deltaTime + 1.0f / 2 * dot.ay * deltaTime * deltaTime;
		CGFloat newX = dot.position.x + sX;
		CGFloat newY = dot.position.y + sy;
		dot.position = CGPointMake(newX, newY);
		dot.opacity = 1.0 - lifeTime * 1.0 / animationDur;
		[CATransaction commit];
	}
	[dotsCopy release];
}

-(void) addSparkAtPoint:(CGPoint) point colors:(NSArray<NSColor *> *) colors {
	@synchronized (self.dots) {
		NSInteger bubleCount = [NSNumber randomBetween:10 and:16];
		for (int i = 0; i < bubleCount; ++i) {
			// 直径
			NSInteger bubleDiameter = [NSNumber randomBetween:3 and:6];
			NSInteger clrIndex = [NSNumber randomBetween:0 and:colors.count];
			CDPDot *dot = [[[CDPDot alloc] initWithFrame:CGRectMake(0, 0, bubleDiameter, bubleDiameter) dotColor:[colors objectAtIndex:clrIndex]] autorelease];
			dot.position = CGPointMake(point.x, self.frame.size.height - point.y);
			dot.vx = [NSNumber randomBetween:1 and:5] * 0.1 * [NSNumber randomSign] / 3;
			dot.ax = [NSNumber randomBetween:1 and:2] * 0.1 * [NSNumber randomSign] / 3;
			dot.vy = [NSNumber randomBetween:0 and:10] / 3;
			dot.ay = [NSNumber randomBetween:1 and:5] * 0.1 * -1 / 3;
			dot.delegate = self;
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
