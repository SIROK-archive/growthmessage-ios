//
//  GMImageMessageHandler.m
//  GrowthMessage
//
//  Created by Naoyuki Kataoka on 2015/04/20.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "GMImageMessageHandler.h"
#import "GMImageMessage.h"
#import "GMScreenButton.h"
#import "GMCloseButton.h"
#import "GMImageButton.h"

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
    NSArray *screenButtons = [self extractButtonsWithType:GMButtonTypeScreen imageMessage:imageMessage];
    NSArray *imageButtons = [self extractButtonsWithType:GMButtonTypeImage imageMessage:imageMessage];
    NSArray *closeButtons = [self extractButtonsWithType:GMButtonTypeClose imageMessage:imageMessage];

    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];

    CGFloat width = MIN(imageMessage.picture.width, window.frame.size.width * 0.85);
    CGFloat height = MIN(imageMessage.picture.height, window.frame.size.height * 0.85);

    if ( width / height > imageMessage.picture.width / imageMessage.picture.height ) {
        height = imageMessage.picture.height * width / imageMessage.picture.width;
    } else {
        width = imageMessage.picture.width * height / imageMessage.picture.height;
    }
    
    CGFloat ratio = width / imageMessage.picture.width;

    CGFloat left = (window.frame.size.width - width) / 2;
    CGFloat top = (window.frame.size.height - height) / 2;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(left, top, width, height)];
    imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageMessage.picture.url]]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [window addSubview:imageView];
    
    return YES;

}

- (NSArray *)extractButtonsWithType:(GMButtonType)type imageMessage:(GMImageMessage *)imageMessage {
    
    NSMutableArray *buttons = [NSMutableArray array];
    
    for (GMButton *button in imageMessage.buttons)
        if(button.type == type)
            [buttons addObject:button];
    
    return buttons;
    
}

@end
