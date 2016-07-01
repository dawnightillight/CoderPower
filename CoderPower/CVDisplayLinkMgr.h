//
//  CVDisplayLinkMgr.h
//  CoderPower
//
//  Created by tyzual on 7/1/16.
//  Copyright © 2016 Dawn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <CoreVideo/CoreVideo.h>

@interface CVDisplayLinkMgr : NSObject
@property (nonatomic, assign) CVDisplayLinkRef displayLink;
@property (atomic, retain) NSMutableArray<NSView *> *views;

+(instancetype) getInstance;

-(instancetype) init;


@end
