//
//  GMImageMessageHandler.m
//  GrowthMessage
//
//  Created by Naoyuki Kataoka on 2015/04/20.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "GMImageMessageHandler.h"
#import "GMImageMessageRenderer.h"

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
    
    [[[GMImageMessageRenderer alloc] initWithImageMessage:imageMessage] show];
    
    return YES;

}

@end
