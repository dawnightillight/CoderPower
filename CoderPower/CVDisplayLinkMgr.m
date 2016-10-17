//
//  CVDisplayLinkMgr.m
//  CoderPower
//
//  Created by tyzual on 7/1/16.
//  Copyright © 2016 Dawn. All rights reserved.
//

#import "CVDisplayLinkMgr.h"

@interface CVDisplayLinkMgr()

@property (nonatomic, assign) CVDisplayLinkRef displayLink;
@property (atomic, retain) NSMutableArray<id<CDPBubleAnimateDelegate>> *bubleDelegate;

@end

@implementation CVDisplayLinkMgr

static CVReturn renderCallback(CVDisplayLinkRef displayLink,
							   const CVTimeStamp *inNow,
							   const CVTimeStamp *inOutputTime,
							   CVOptionFlags flagsIn,
							   CVOptionFlags *flagsOut,
							   void *displayLinkContext) {
	static long long deltaTime = 0;
	deltaTime = inOutputTime->hostTime - inNow->hostTime;
	CVDisplayLinkMgr *mgr = [CVDisplayLinkMgr getInstance];
	[mgr updateAnimate:deltaTime];
	return kCVReturnSuccess;
}

+(instancetype) getInstance {
	static CVDisplayLinkMgr *_instance;
	static dispatch_once_t _onceFlag;
	dispatch_once(&_onceFlag, ^{
		_instance = [[CVDisplayLinkMgr alloc] init];
		CVDisplayLinkSetOutputCallback(_instance.displayLink, renderCallback, NULL);
		CVDisplayLinkStart(_instance.displayLink);
	});
	return _instance;
}

-(instancetype) init {
	if ((self = [super init]) != nil) {
		CGDirectDisplayID   displayID = CGMainDisplayID();
		CVDisplayLinkCreateWithCGDisplay(displayID, &_displayLink);
		self.bubleDelegate = [[[NSMutableArray<id<CDPBubleAnimateDelegate>> alloc] init] autorelease];
	}
	return self;
}

-(void) addBubleAnimtateDelegate:(id<CDPBubleAnimateDelegate>) delegate {
	@synchronized (self.bubleDelegate) {
		[self.bubleDelegate addObject:delegate];
	}
}

-(void) deleteBubleAnimtateDelegate:(id<CDPBubleAnimateDelegate>) delegate {
	@synchronized (self.bubleDelegate) {
		[self.bubleDelegate removeObject:delegate];
	}
}

-(void) updateAnimate:(long long) deltaTime {
	NSArray<id<CDPBubleAnimateDelegate>> *animateCopy = nil;
	@synchronized (self.bubleDelegate) {
		animateCopy = [self.bubleDelegate copy];
	}
	dispatch_async(dispatch_get_main_queue(), ^{
		for (id<CDPBubleAnimateDelegate> bubleAnimate in animateCopy) {
			[bubleAnimate animate:deltaTime];
		}
	});
	[animateCopy release];
}

-(void) dealloc {
	[self.bubleDelegate removeAllObjects];
	self.bubleDelegate = nil;
	CVDisplayLinkStop(self.displayLink);
	CVDisplayLinkRelease(self.displayLink);
	[super dealloc];
}

@end
