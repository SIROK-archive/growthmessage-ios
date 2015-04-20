//
//  GMImageMessageHandler.m
//  GrowthMessage
//
//  Created by Naoyuki Kataoka on 2015/04/20.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "GMImageMessageHandler.h"
#import "GMImageMessageRenderer.h"

@interface GMImageMessageHandler () {
    
    GMImageMessageRenderer *imageMessageRenderer;
    
}

@property (nonatomic, strong) GMImageMessageRenderer *imageMessageRenderer;

@end

@implementation GMImageMessageHandler

@synthesize imageMessageRenderer;

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
    
    self.imageMessageRenderer = [[GMImageMessageRenderer alloc] initWithImageMessage:imageMessage];
    [imageMessageRenderer show];
    
    return YES;

}

@end
