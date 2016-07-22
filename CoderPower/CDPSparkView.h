//
//  CDPSparkView.h
//  CoderPower
//
//  Created by tyzual on 7/1/16.
//  Copyright © 2016 Dawn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CDPSparkView : NSView

-(instancetype) initWithFrame:(NSRect)frameRect;

-(void) addSparkAtPoint:(CGPoint) point colors:(NSArray<NSColor *> *) colors;

@end
