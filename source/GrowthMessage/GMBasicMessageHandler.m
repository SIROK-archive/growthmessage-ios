//
//  GMBasicMessageHandler.m
//  GrowthMessage
//
//  Created by 堀内 暢之 on 2015/03/03.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMBasicMessageHandler.h"
#import "GMButton.h"

@interface GMBasicMessageHandler() <UIAlertViewDelegate>

@end

@implementation GMBasicMessageHandler
- (BOOL)handleMessage:(GMMessage *)message {
	if ([message.type isEqualToString:@"plain"]) {
		//let's show the message
		dispatch_async(dispatch_get_main_queue(), ^{
			//TODO: UIAlertController support
			UIAlertView *alertView = [[UIAlertView alloc] init];
			alertView.delegate = self;
			alertView.title = message.title;
			alertView.message = message.body;
			for (GMButton *button in message.buttons) {
				[alertView addButtonWithTitle:button.label];
			}
			[alertView show];
		});
		return YES;
	} else {
		return NO;
	}
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	//TODO: implement me
	
}
@end
