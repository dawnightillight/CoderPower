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

@property(nonatomic, retain) NSMenuItem *switchItem;

@end

@implementation CDPMainMenuItem

+ (instancetype)item {
    CDPMainMenuItem *menuItem = [[CDPMainMenuItem alloc] initWithTitle:[NSString stringWithFormat:@"CoderPower(%@)", CDPAppVersion] action:nil keyEquivalent:@""];
    
    if (menuItem) {
        NSMenu *mainMenu = [[[NSMenu alloc] initWithTitle:@"CoderPower"] autorelease];
        mainMenu.autoenablesItems = NO;
        menuItem.submenu = mainMenu;
        
        // main
        NSMenuItem *switchItem = [[[NSMenuItem alloc] initWithTitle:@"Disable CoderPower" action:@selector(switchItemClick:) keyEquivalent:@""] autorelease];
        switchItem.target = menuItem;
        [mainMenu addItem:switchItem];
        menuItem.switchItem = switchItem;
		[menuItem updateTitles];
    }
    return [menuItem autorelease];
}

- (void)dealloc
{
    self.switchItem = nil;
    [super dealloc];
}

#pragma mark -

- (void)updateTitles
{
    if (CDPUserInfoManager.isOn) {
        _switchItem.title = @"Disable CoderPower";
    } else {
        _switchItem.title = @"Enable CoderPower";
    }
}

- (void)switchItemClick:(id)sender
{
    CDPUserInfoManager.isOn = !CDPUserInfoManager.isOn;
    [self updateTitles];
}

//- (void)shakeItemClick:(id)sender
//{
//    CDPUserInfoManager.isShakeOn = !CDPUserInfoManager.isShakeOn;
//    [self updateTitles];
//
//}
//
//- (void)effectWhiteItemClick:(id)sender
//{
//    CDPUserInfoManager.effectType = CDPUserInfoEffectTypeWhite;
//    [self updateTitles];
//}
//
//- (void)effectOrangeItemClick:(id)sender
//{
//    CDPUserInfoManager.effectType = CDPUserInfoEffectTypeOrange;
//    [self updateTitles];
//
//}

@end
