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
    
    CGRect rect = CGRectMake(left, top, width, height);
    
    [self showBackground];
    [self showImageWithRect:rect ratio:ratio];
    [self showScreenButtonWithRect:rect ratio:ratio];
    [self showImageButtonsWithRect:rect ratio:ratio];
    [self showCloseButtonWithRect:rect ratio:ratio];
    
}

- (void)showBackground {
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    self.view = [[UIView alloc] initWithFrame:window.frame];
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [window addSubview:view];
    
}

- (void)showImageWithRect:(CGRect)rect ratio:(CGFloat)ratio {
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageMessage.picture.url]]];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.userInteractionEnabled = YES;
    [view addSubview:imageView];
    
}

- (void)showScreenButtonWithRect:(CGRect)rect ratio:(CGFloat)ratio {
    
    GMScreenButton *screenButton = [[self extractButtonsWithType:GMButtonTypeScreen] lastObject];
    if (!screenButton) {
        return;
    }
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageMessage.picture.url]]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    button.contentMode = UIViewContentModeScaleAspectFit;
    button.frame = rect;
    [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    [boundButtons setObject:button forKey:[NSValue valueWithNonretainedObject:button]];
    
}

- (void)showImageButtonsWithRect:(CGRect)rect ratio:(CGFloat)ratio {
    
    NSArray *imageButtons = [self extractButtonsWithType:GMButtonTypeImage];
    
    CGFloat top = rect.origin.y + rect.size.height;
    for (GMImageButton *imageButton in [imageButtons reverseObjectEnumerator]) {
        
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageButton.picture.url]]];
        CGFloat width = imageButton.picture.width * ratio;
        CGFloat height = imageButton.picture.height * ratio;
        CGFloat left = rect.origin.x + (rect.size.width - width) / 2;
        top -= height;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:image forState:UIControlStateNormal];
        button.contentMode = UIViewContentModeScaleAspectFit;
        button.frame = CGRectMake(left, top, width, height);
        [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        [boundButtons setObject:imageButton forKey:[NSValue valueWithNonretainedObject:button]];
        
    }
    
}

- (void)showCloseButtonWithRect:(CGRect)rect ratio:(CGFloat)ratio {
    
    GMCloseButton *closeButton = [[self extractButtonsWithType:GMButtonTypeClose] lastObject];
    if (!closeButton) {
        return;
    }
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:closeButton.picture.url]]];
    CGFloat width = closeButton.picture.width * ratio;
    CGFloat height = closeButton.picture.height * ratio;
    CGFloat left = rect.origin.x + rect.size.width - width / 2;
    CGFloat top = rect.origin.y - height / 2;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    button.contentMode = UIViewContentModeScaleAspectFit;
    button.frame = CGRectMake(left, top, width, height);
    [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    [boundButtons setObject:closeButton forKey:[NSValue valueWithNonretainedObject:button]];
    
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
