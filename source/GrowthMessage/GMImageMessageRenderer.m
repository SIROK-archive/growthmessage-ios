//
//  GMImageMessageRenderer.m
//  GrowthMessage
//
//  Created by Naoyuki Kataoka on 2015/04/21.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "GMImageMessageRenderer.h"
#import "GrowthMessage.h"
#import "GMScreenButton.h"
#import "GMCloseButton.h"
#import "GMImageButton.h"

@interface GMImageMessageRenderer () {
    
    NSMutableDictionary *boundButtons;
    UIView *view;
    
}

@property (nonatomic, strong) NSMutableDictionary *boundButtons;
@property (nonatomic, strong) UIView *view;

@end

@implementation GMImageMessageRenderer

@synthesize imageMessage;
@synthesize boundButtons;
@synthesize view;

- (instancetype)initWithImageMessage:(GMImageMessage *)newImageMessage {
    self = [super init];
    if(self){
        self.imageMessage = newImageMessage;
        self.boundButtons = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)show {
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    self.view = [[UIView alloc] initWithFrame:window.frame];
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [window addSubview:view];
    
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
    imageView.userInteractionEnabled = YES;
    [view addSubview:imageView];
    
    GMScreenButton *screenButton = [[self extractButtonsWithType:GMButtonTypeScreen] lastObject];
    if (screenButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:image forState:UIControlStateNormal];
        button.contentMode = UIViewContentModeScaleAspectFit;
        button.frame = CGRectMake(0, 0, width, height);
        [boundButtons setObject:button forKey:[NSValue valueWithNonretainedObject:button]];
        [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:button];
    }
    
    NSArray *imageButtons = [self extractButtonsWithType:GMButtonTypeImage];
    CGFloat imageButtonTop = height;
    for (GMImageButton *imageButton in [imageButtons reverseObjectEnumerator]) {
        CGFloat imageButtonWidth = imageButton.picture.width * ratio;
        CGFloat imageButtonHeight = imageButton.picture.height * ratio;
        CGFloat imageButtonLeft = (width - imageButtonWidth) / 2;
        imageButtonTop -= imageButtonHeight;
        UIImage *imageButtonImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageButton.picture.url]]];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:imageButtonImage forState:UIControlStateNormal];
        button.contentMode = UIViewContentModeScaleAspectFit;
        button.frame = CGRectMake(imageButtonLeft, imageButtonTop, imageButtonWidth, imageButtonHeight);
        [boundButtons setObject:imageButton forKey:[NSValue valueWithNonretainedObject:button]];
        [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:button];
    }
    
    GMCloseButton *closeButton = [[self extractButtonsWithType:GMButtonTypeClose] lastObject];
    if (closeButton) {
        CGFloat closeButtonWidth = closeButton.picture.width * ratio;
        CGFloat closeButtonHeight = closeButton.picture.height * ratio;
        CGFloat closeButtonLeft = width - closeButtonWidth / 2;
        CGFloat closeButtonTop = - closeButtonHeight / 2;
        UIImage *closeButtonImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:closeButton.picture.url]]];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:closeButtonImage forState:UIControlStateNormal];
        button.contentMode = UIViewContentModeScaleAspectFit;
        button.frame = CGRectMake(closeButtonLeft, closeButtonTop, closeButtonWidth, closeButtonHeight);
        [boundButtons setObject:closeButton forKey:[NSValue valueWithNonretainedObject:button]];
        [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:button];
    }
    
}

- (NSArray *) extractButtonsWithType:(GMButtonType)type {
    
    NSMutableArray *buttons = [NSMutableArray array];
    
    for (GMButton *button in imageMessage.buttons) {
        if (button.type == type) {
            [buttons addObject:button];
        }
    }
    
    return buttons;
    
}

- (void) tapButton:(id)sender {
    
    GMButton *button = [boundButtons objectForKey:[NSValue valueWithNonretainedObject:sender]];
    
    [[GrowthMessage sharedInstance] selectButton:button message:imageMessage];
    
    // TODO Release bound buttons
    
}

@end
