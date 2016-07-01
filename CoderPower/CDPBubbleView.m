//
//  CDPBubbleView.m
//  CoderPower
//
//  Created by tyzual on 7/1/16.
//  Copyright © 2016 Dawn. All rights reserved.
//

#import "CDPBubbleView.h"

#import <QuartzCore/CAEmitterLayer.h>
#import <QuartzCore/CAEmitterCell.h>

@interface CDPDotView : NSView
@property (nonatomic, retain) NSColor *color;

-(instancetype) initWithFrame:(NSRect) frameRect dotClor:(NSColor *)dotColor;

@end

@implementation CDPDotView

-(instancetype) initWithFrame:(NSRect) frameRect dotClor:(NSColor *)dotColor {
	if ((self = [super initWithFrame:frameRect]) != nil) {
		self.color = dotColor;
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

@interface CDPBubbleView()
@property (nonatomic, retain) NSMutableArray<CDPDotView *> *dots;
@end

@implementation CDPBubbleView

-(instancetype) initWithFrame:(NSRect)frameRect {
	if ((self = [super initWithFrame:frameRect]) != nil) {
		self.dots = [[NSMutableArray<CDPDotView *> alloc] init];
		for (int i = 0; i < 10; ++i) {
//			self.dots addObject:[CDPDotView alloc] initWithFrame
		}
//		self.wantsLayer = YES;
//
//		NSImage *circleImg = [[[NSImage alloc] initWithSize:CGSizeMake(10, 10)] autorelease];
//		[circleImg lockFocus];
//		CGContextRef con = [[NSGraphicsContext currentContext] graphicsPort];
//		CGContextAddEllipseInRect(con, CGRectMake(0, 0, 10, 10));
//		CGContextSetFillColorWithColor(con, [NSColor blueColor].CGColor);
//		CGContextFillPath(con);
//		[circleImg unlockFocus];
//		CGImageSourceRef source = CGImageSourceCreateWithData((CFDataRef)[circleImg TIFFRepresentation], NULL);
//		CGImageRef cgImg = CGImageSourceCreateImageAtIndex(source, 0, NULL);
//		CAEmitterCell *cell = [[[CAEmitterCell alloc] init] autorelease];
//		cell.birthRate = 100;
//		cell.lifetime = 5;
//		cell.velocity = 1000;
////		cell.velocityRange = 25;
//		cell.emissionLongitude = M_PI_2;
//		cell.emissionRange = M_PI_2 / 2;
//		cell.yAcceleration = -7000;
////		cell.duration = 1;
//		cell.contents = (id)cgImg;
//
//		CAEmitterLayer *emitLayer = [[[CAEmitterLayer alloc] init] autorelease];
//		emitLayer.position = CGPointMake(self.bounds.size.width / 2, 0);
//		emitLayer.emitterSize = CGSizeMake(100, 100);
//		emitLayer.emitterShape = kCAEmitterLayerPoint;
//		emitLayer.emitterMode = kCAEmitterLayerPoint;
//		emitLayer.emitterCells = @[cell];
//		
//		self.emitLayer = emitLayer;
//		[self.layer addSublayer:emitLayer];

		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			[self removeFromSuperview];
			[self release];
		});

	}
	return self;
}

@end
