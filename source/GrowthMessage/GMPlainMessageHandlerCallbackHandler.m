//
//  GMPlainMessageHandlerCallbackHandler.m
//  GrowthMessage
//
//  Created by Naoyuki Kataoka on 2015/04/07.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "GMPlainMessageHandlerCallbackHandler.h"
#import "GrowthMessage.h"

@implementation GMPlainMessageHandlerCallbackHandler

@synthesize plainMessage;

- (instancetype)initWithPlainMessage:(GMPlainMessage *)newPlainMessage {
    self = [super init];
    if(self) {
        self.plainMessage = newPlainMessage;
    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    GMButton *button = [plainMessage.buttons objectAtIndex:buttonIndex];
    [[GrowthMessage sharedInstance] didSelectButton:button message:plainMessage];
}

@end
