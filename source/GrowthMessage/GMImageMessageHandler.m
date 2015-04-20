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
    
    NSMutableArray *imageMessageRenderers;
    
}

@property (nonatomic, strong) NSMutableArray *imageMessageRenderers;

@end

@implementation GMImageMessageHandler

@synthesize imageMessageRenderers;

- (instancetype) init {
    self = [super init];
    if (self) {
        self.imageMessageRenderers = [[NSMutableArray alloc] init];
    }
    return self;
}

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
    
    GMImageMessageRenderer *imageMessageRenderer = [[GMImageMessageRenderer alloc] initWithImageMessage:imageMessage];
    [imageMessageRenderer show];
    [imageMessageRenderers addObject:imageMessageRenderer];
    
    return YES;

}

@end
