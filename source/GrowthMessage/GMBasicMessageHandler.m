//
//  GMBasicMessageHandler.m
//  GrowthMessage
//
//  Created by 堀内 暢之 on 2015/03/03.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "GMBasicMessageHandler.h"
#import "GMButton.h"
#import "GrowthMessage.h"

@interface GMBasicMessageHandler() <UIAlertViewDelegate>

@end

@implementation GMBasicMessageHandler
- (BOOL)handleMessage:(GMMessage *)message manager:(GrowthMessage*)manager {
	if ([message.format isEqualToString:@"plain"]) {
		//let's show the message
		dispatch_async(dispatch_get_main_queue(), ^{
			//TODO: UIAlertController support
			UIAlertView *alertView = [[UIAlertView alloc] init];
			objc_setAssociatedObject(alertView, "gm_message", message, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
			objc_setAssociatedObject(alertView, "gm_manager", manager, OBJC_ASSOCIATION_ASSIGN);
			
			alertView.delegate = self;
			alertView.title = [message.data objectForKey:@"title"];
			alertView.message = [message.data objectForKey:@"body"];
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
	__strong GMMessage *message = objc_getAssociatedObject(alertView, "gm_message");
	GrowthMessage *manager = objc_getAssociatedObject(alertView, "gm_manager");
	objc_setAssociatedObject(alertView, "gm_message", nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	objc_setAssociatedObject(alertView, "gm_manager", nil, OBJC_ASSOCIATION_ASSIGN);
	
	[manager didSelectButton:[[message buttons] objectAtIndex:buttonIndex] message:message];
}
@end
