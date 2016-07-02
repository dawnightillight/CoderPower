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
//@property(nonatomic, retain) NSMenuItem *shakeItem;
//@property(nonatomic, retain) NSMenuItem *effectItem;
//@property(nonatomic, retain) NSMenuItem *effectWhiteItem;
//@property(nonatomic, retain) NSMenuItem *effectOrangeItem;

@end

@implementation CDPMainMenuItem

+ (instancetype)item;
{
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
        
//        [mainMenu addItem:[NSMenuItem separatorItem]];
		
        // shake
//        NSMenuItem *shakeItem = [[[NSMenuItem alloc] initWithTitle:@"Disable Shake" action:@selector(shakeItemClick:) keyEquivalent:@""] autorelease];
//        shakeItem.target = menuItem;
//        [mainMenu addItem:shakeItem];
//        menuItem.shakeItem = shakeItem;
		
        // effect
//        NSMenuItem *effectItem = [[NSMenuItem alloc] initWithTitle:@"Typing Effect" action:nil keyEquivalent:@""];
//        [mainMenu addItem:effectItem];
//        menuItem.effectItem = effectItem;
//        [effectItem release];
//        
//        NSMenu *effectMenu = [[NSMenu alloc] initWithTitle:@""];
//        effectMenu.autoenablesItems = NO;
//        effectItem.submenu = effectMenu;
//        [effectMenu release];
//        
//        NSMenuItem *effectWhiteItem = [[NSMenuItem alloc] initWithTitle:@"White" action:@selector(effectWhiteItemClick:) keyEquivalent:@""];
//        effectWhiteItem.target = menuItem;
//        [effectMenu addItem:effectWhiteItem];
//        menuItem.effectWhiteItem = effectWhiteItem;
//        [effectWhiteItem release];
//        
//        NSMenuItem *effectOrangeItem = [[NSMenuItem alloc] initWithTitle:@"Orange" action:@selector(effectOrangeItemClick:) keyEquivalent:@""];
//        effectOrangeItem.target = menuItem;
//        [effectMenu addItem:effectOrangeItem];
//        menuItem.effectOrangeItem = effectOrangeItem;
//        [effectOrangeItem release];

        [menuItem updateTitles];
    }
    return [menuItem autorelease];
}

- (void)dealloc
{
    self.switchItem = nil;
//    self.shakeItem = nil;
//    self.effectItem = nil;
//    self.effectWhiteItem = nil;
//    self.effectOrangeItem = nil;
    [super dealloc];
}

#pragma mark -

- (void)updateTitles
{
//    _shakeItem.enabled = _effectItem.enabled = _effectWhiteItem.enabled = _effectOrangeItem.enabled = CDPUserInfoManager.isOn;
    if (CDPUserInfoManager.isOn) {
        _switchItem.title = @"Disable CoderPower";
    } else {
        _switchItem.title = @"Enable CoderPower";
    }
//    if (CDPUserInfoManager.isShakeOn) {
//        _shakeItem.title = @"Disable Shake";
//    } else {
//        _shakeItem.title = @"Enable Shake";
//    }
	
//    if (CDPUserInfoManager.effectType == CDPUserInfoEffectTypeWhite) {
//        _effectWhiteItem.state = NSOnState;
//        _effectOrangeItem.state = NSOffState;
//    } else {
//        _effectWhiteItem.state = NSOffState;
//        _effectOrangeItem.state = NSOnState;
//    }
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
