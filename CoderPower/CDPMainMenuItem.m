//
//  CDPMainMenuItem.m
//  CoderPower
//
//  Created by Dawn on 15/11/30.
//  Copyright © 2015年 Dawn. All rights reserved.
//

#import "CDPMainMenuItem.h"
#import "Defination.h"
#import "CDPUserInfoManager.h"

@interface CDPMainMenuItem ()

@property(nonatomic, retain) NSMenuItem *shake;
@property(nonatomic, retain) NSMenuItem *bubble;

@end

@implementation CDPMainMenuItem

+ (instancetype)item {
    CDPMainMenuItem *menuItem = [[CDPMainMenuItem alloc] initWithTitle:[NSString stringWithFormat:@"CoderPower(%@)", CDPAppVersion] action:nil keyEquivalent:@""];

    if (menuItem) {
        NSMenu *mainMenu = [[[NSMenu alloc] initWithTitle:@"CoderPower"] autorelease];
        mainMenu.autoenablesItems = NO;
        menuItem.submenu = mainMenu;

        // shake item
        NSMenuItem *switchItem = [[[NSMenuItem alloc] initWithTitle:@"Disable Shake" action:@selector(shakeItemClick:) keyEquivalent:@""] autorelease];
        switchItem.target = menuItem;
        [mainMenu addItem:switchItem];
        menuItem.shake = switchItem;

		// buble
		NSMenuItem *bubbleItem = [[[NSMenuItem alloc] initWithTitle:@"Disable Bubble" action:@selector(bubbleItemClick:) keyEquivalent:@""] autorelease];
		bubbleItem.target = menuItem;
		[mainMenu addItem:bubbleItem];
		menuItem.bubble = bubbleItem;
		[menuItem updateTitles];
    }
    return [menuItem autorelease];
}

- (void)dealloc
{
    self.shake = nil;
	self.bubble = nil;
    [super dealloc];
}

#pragma mark -

- (void)updateTitles {
    if (CDPUserInfoManager.isShakeOn) {
        self.shake.title = @"Disable Shake";
    } else {
        self.shake.title = @"Enable Shake";
    }

	if (CDPUserInfoManager.isBubbleOn) {
		self.bubble.title = @"Disable Bubble";
	} else {
		self.bubble.title = @"Enable Bubble";
	}
}

- (void)shakeItemClick:(id)sender {
    CDPUserInfoManager.isShakeOn = !CDPUserInfoManager.isShakeOn;
    [self updateTitles];
}

- (void)bubbleItemClick:(id)sender {
	CDPUserInfoManager.isBubbleOn = !CDPUserInfoManager.isBubbleOn;
	[self updateTitles];
}

@end
