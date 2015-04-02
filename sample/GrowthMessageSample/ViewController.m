//
//  ViewController.m
//  GrowthMessageSample
//
//  Created by Naoyuki Kataoka on 2015/03/02.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "ViewController.h"
#import <GrowthMessage/GrowthMessage.h>
#import <GrowthMessage/GMBasicMessageHandler.h>
#import <GrowthMessage/GMButton.h>
#import <GrowthMessage/GMNopeIntentHandler.h>
#import <GrowthMessage/GMOpenBrowserIntentHandler.h>

@interface ViewController () <GrowthMessageDelegate>

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	[[GrowthMessage sharedInstance] setDelegate:self];
}

#pragma mark --
#pragma mark GrowthMessageDelegate

- (BOOL)shouldShowMessage:(GMMessage *)message {
	return YES;
}

@end
