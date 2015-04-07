//
//  GMPlainMessageHandler.m
//  GrowthMessage
//
//  Created by 堀内 暢之 on 2015/03/03.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "GMPlainMessageHandler.h"
#import "GMPlainMessage.h"
#import "GMPlainButton.h"
#import "GMPlainMessageHandlerCallbackHandler.h"

@interface GMPlainMessageHandler () {
 
    GMPlainMessageHandlerCallbackHandler *callbackHandler;
    
}

@property (nonatomic, strong) GMPlainMessageHandlerCallbackHandler *callbackHandler;

@end

@implementation GMPlainMessageHandler

@synthesize callbackHandler;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.callbackHandler = [[GMPlainMessageHandlerCallbackHandler alloc] init];
    }
    return self;
}

- (BOOL)handleMessage:(GMMessage *)message {
    
    if (message.type != GMMessageTypePlain)
        return NO;
    
    if (![message isKindOfClass:[GMPlainMessage class]])
        return NO;
    
    GMPlainMessage *plainMessage = (GMPlainMessage *)message;
    
    UIAlertView *alertView = [[UIAlertView alloc] init];
    
    callbackHandler.plainMessage = plainMessage;
    alertView.delegate = callbackHandler;
    alertView.title = plainMessage.caption;
    alertView.message = plainMessage.text;
    
    for (GMButton *button in plainMessage.buttons) {
        GMPlainButton *plainButton = (GMPlainButton *)button;
        [alertView addButtonWithTitle:plainButton.label];
    }
    
    [alertView show];
    
    return YES;
    
}

@end
