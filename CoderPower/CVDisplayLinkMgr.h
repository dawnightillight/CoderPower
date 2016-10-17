//
//  CVDisplayLinkMgr.h
//  CoderPower
//
//  Created by tyzual on 7/1/16.
//  Copyright © 2016 Dawn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreVideo/CoreVideo.h>

#import "CDPBubleAnimateDelegate.h"

@interface CVDisplayLinkMgr : NSObject

+(instancetype) getInstance;

-(instancetype) init;

-(void) addBubleAnimtateDelegate:(id<CDPBubleAnimateDelegate>) delegate;
-(void) deleteBubleAnimtateDelegate:(id<CDPBubleAnimateDelegate>) delegate;

@end
