//
//  CDPViewAnimation.h
//  CoderPower
//
//  Created by Dawn on 15/11/30.
//  Copyright © 2015年 Dawn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CDPViewAnimation : NSAnimation

@property(nonatomic, assign) NSInteger tag;

@property(nonatomic, retain) NSView *targetView;
@property(nonatomic, assign) CGFloat fromAlpha;
@property(nonatomic, assign) CGFloat toAlpha;
@property(nonatomic, assign) NSRect fromFrame;
@property(nonatomic, assign) NSRect toFrame;

@end
