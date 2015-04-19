//
//  GMImageMessageHandler.m
//  GrowthMessage
//
//  Created by Naoyuki Kataoka on 2015/04/20.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "GMImageMessageHandler.h"
#import "GMImageMessage.h"

@implementation GMImageMessageHandler

#pragma mark --
#pragma mark GMMessageHandler

- (BOOL) handleMessage:(GMMessage *)message {
    
    if (message.type != GMMessageTypeImage) {
        return NO;
    }
    
    if (![message isKindOfClass:[GMImageMessage class]]) {
        return NO;
    }
    
    GMImageMessage *imageMessage = (GMImageMessage *)message;
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    // TODO Show image
    [window addSubview:[[UIView alloc] initWithFrame:CGRectMake(0, 0, window.frame.size.width, window.frame.size.height)]];
    
    return YES;
    
}

@end
