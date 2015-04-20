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
    GMScreenButton *screenButton = nil;
    if ([screenButtons count] > 0) {
        screenButton = [screenButtons objectAtIndex:0];
    }
    
    NSArray *imageButtons = [self extractButtonsWithType:GMButtonTypeImage imageMessage:imageMessage];
    
    NSArray *closeButtons = [self extractButtonsWithType:GMButtonTypeClose imageMessage:imageMessage];
    GMCloseButton *closeButton = nil;
    if ([closeButtons count] > 0) {
        closeButton = [closeButtons objectAtIndex:0];
    }

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
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageMessage.picture.url]]];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(left, top, width, height)];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [window addSubview:imageView];
    
    if (screenButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:image forState:UIControlStateNormal];
        button.contentMode = UIViewContentModeScaleAspectFit;
        button.frame = CGRectMake(0, 0, width, height);
        [imageView addSubview:button];
    }
    
    CGFloat imageButtonTop = height;
    for (GMImageButton *imageButton in [imageButtons reverseObjectEnumerator]) {
        CGFloat imageButtonWidth = imageButton.picture.width * ratio;
        CGFloat imageButtonHeight = imageButton.picture.height * ratio;
        imageButtonTop -= imageButtonHeight;
        CGFloat imageButtonLeft = (width - imageButtonWidth) / 2;
        UIImage *imageButtonImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageButton.picture.url]]];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:imageButtonImage forState:UIControlStateNormal];
        button.contentMode = UIViewContentModeScaleAspectFit;
        button.frame = CGRectMake(imageButtonLeft, imageButtonTop, imageButtonWidth, imageButtonHeight);
        [imageView addSubview:button];
    }
    
    if (closeButton) {
        // TODO implement close button
    }
    
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
