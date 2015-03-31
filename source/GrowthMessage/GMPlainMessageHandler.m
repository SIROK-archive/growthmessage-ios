//
//  GMPlainMessageHandler.m
//  GrowthMessage
//
//  Created by 堀内 暢之 on 2015/03/03.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "GMPlainMessageHandler.h"
#import "GMButton.h"
#import "GrowthMessage.h"
#import "GMPlainMessage.h"
#import "GMPlainButton.h"

@interface GMPlainMessageHandler() <UIAlertViewDelegate>

@end

@implementation GMPlainMessageHandler

- (BOOL)handleMessage:(GMMessage *)message {
    
    if (message.type != GMMessageTypePlain)
        return NO;
    if (![message isKindOfClass:[GMPlainMessage class]])
        return NO;
    
    GMPlainMessage *plainMessage = (GMPlainMessage *)message;
    
    //let's show the message
    dispatch_async(dispatch_get_main_queue(), ^{
        //TODO: UIAlertController support
        UIAlertView *alertView = [[UIAlertView alloc] init];
        objc_setAssociatedObject(alertView, "gm_message", message, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        alertView.delegate = self;
        alertView.title = plainMessage.caption;
        alertView.message = plainMessage.text;
        for (GMPlainButton *plainButton in plainMessage.buttons) {
            [alertView addButtonWithTitle:plainButton.label];
        }
        [alertView show];
    });
    
    return YES;
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    __strong GMPlainMessage *plainMessage = objc_getAssociatedObject(alertView, "gm_message");
    GrowthMessage *manager = objc_getAssociatedObject(alertView, "gm_manager");
    objc_setAssociatedObject(alertView, "gm_message", nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [manager didSelectButton:[plainMessage.buttons objectAtIndex:buttonIndex] message:plainMessage];
}

@end
