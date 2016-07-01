//
//  CVDisplayLinkMgr.m
//  CoderPower
//
//  Created by tyzual on 7/1/16.
//  Copyright © 2016 Dawn. All rights reserved.
//

#import "CVDisplayLinkMgr.h"

@implementation CVDisplayLinkMgr

+(instancetype) getInstance {
	static CVDisplayLinkMgr *_instance;
	static dispatch_once_t _onceFlag;
	dispatch_once(&_onceFlag, ^{
		_instance = [[CVDisplayLinkMgr alloc] init];
	});
	return _instance;
}

-(instancetype) init {
	if ((self = [super init]) != nil) {
		CGDirectDisplayID   displayID = CGMainDisplayID();
		CVDisplayLinkCreateWithCGDisplay(displayID, &_displayLink);
		self.views = [[NSMutableArray<NSView *> alloc] init];
	}
	return self;
}

@end
