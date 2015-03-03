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

@interface GrowthMessage (dev) {
	
}
- (void)openMessage:(GMMessage*)message;
@end

@interface ViewController () <GrowthMessageDelegate>

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	[[GrowthMessage sharedInstance] setDelegate:self];
	[[GrowthMessage sharedInstance] setMessageHandlers:
	 [NSArray arrayWithObjects:
	  [[GMBasicMessageHandler alloc] init]
	  , nil]];
    [[GrowthMessage sharedInstance] openMessageIfAvailable];
	
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		GMMessage *dummyMessage = [[GMMessage alloc] init];
		dummyMessage.token = @"1234567abcdefg";
		dummyMessage.type = @"plain";
		dummyMessage.title = @"title";
		dummyMessage.body = @"some text";
		NSMutableArray *buttons = [NSMutableArray array];
		{
			GMButton *button = [[GMButton alloc] init];
			[button setLabel:@"button label"];
			[buttons addObject:button];
		}
		dummyMessage.buttons = buttons;
		
		[[GrowthMessage sharedInstance] openMessage:dummyMessage];
	});
}

- (BOOL)shoudShowMessage:(GMMessage *)message {
	return YES;
}

@end
