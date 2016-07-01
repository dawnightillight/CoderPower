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

@interface CDPBubbleView()

//@property (nonatomic, retain) NSImage *circleImg;

@end

@implementation CDPBubbleView


-(instancetype) initWithFrame:(NSRect)frameRect {
	if ((self = [super initWithFrame:frameRect]) != nil) {
		self.wantsLayer = YES;
		NSImage *circleImg = [[[NSImage alloc] initWithSize:CGSizeMake(2.5, 2.5)] autorelease];
		[circleImg lockFocus];
		CGContextRef con = [[NSGraphicsContext currentContext] graphicsPort];
		CGContextAddEllipseInRect(con, CGRectMake(0, 0, 2.5, 2.5));
		CGContextSetFillColorWithColor(con, [NSColor blueColor].CGColor);
		CGContextFillPath(con);
		[circleImg unlockFocus];
		CGImageSourceRef source = CGImageSourceCreateWithData((CFDataRef)[circleImg TIFFRepresentation], NULL);
		CGImageRef cgImg = CGImageSourceCreateImageAtIndex(source, 0, NULL);
		CAEmitterCell *cell = [[[CAEmitterCell alloc] init] autorelease];
		cell.birthRate = 5;
		cell.lifetime = 1;
		cell.velocity = 100;
		cell.contents = (id)cgImg;

		CAEmitterLayer *emitLayer = [[[CAEmitterLayer alloc] init] autorelease];
		emitLayer.position = CGPointMake(0, 0);
		emitLayer.emitterPosition = CGPointMake(0, self.bounds.size.height / 2);
		emitLayer.emitterSize = CGSizeMake(100, 100);
		emitLayer.emitterShape = kCAEmitterLayerPoint;
		emitLayer.emitterMode = kCAEmitterLayerPoints;
		emitLayer.emitterCells = @[cell];
		[self.layer addSublayer:emitLayer];

	}
	return self;
}

//- (void)drawRect:(NSRect)dirtyRect {
//    [super drawRect:dirtyRect];
//	NSGraphicsContext* aContext = [NSGraphicsContext currentContext];
//	CGContextRef cgContext = [aContext CGContext];
//	CGImageSourceRef source = CGImageSourceCreateWithData((CFDataRef)self.circleImg.TIFFRepresentation, NULL);
//	CGImageRef cgImg = CGImageSourceCreateImageAtIndex(source, 0, NULL);
//	CGContextDrawImage(cgContext, self.bounds, cgImg);
//	[aContext flushGraphics];
//}


@end
