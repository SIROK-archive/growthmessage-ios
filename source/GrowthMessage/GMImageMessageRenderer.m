//
//  GMImageMessageRenderer.m
//  GrowthMessage
//
//  Created by Naoyuki Kataoka on 2015/04/21.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "GMImageMessageRenderer.h"
#import "GMScreenButton.h"
#import "GMCloseButton.h"
#import "GMImageButton.h"

@interface GMImageMessageRenderer () {

    NSMutableDictionary *boundButtons;
    NSMutableDictionary *cachedImages;
    UIView *view;
    UIActivityIndicatorView *activityIndicatorView;

}

@property (nonatomic, strong) NSMutableDictionary *boundButtons;
@property (nonatomic, strong) NSMutableDictionary *cachedImages;
@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation GMImageMessageRenderer

@synthesize imageMessage;
@synthesize delegate;
@synthesize boundButtons;
@synthesize cachedImages;
@synthesize view;
@synthesize activityIndicatorView;

- (instancetype) initWithImageMessage:(GMImageMessage *)newImageMessage {
    self = [super init];
    if (self) {
        self.imageMessage = newImageMessage;
        self.boundButtons = [NSMutableDictionary dictionary];
        self.cachedImages = [NSMutableDictionary dictionary];
    }

    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(show) name:UIDeviceOrientationDidChangeNotification object:nil];

    return self;
}

- (void) show {

    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];

    CGFloat availableWidth = MIN(imageMessage.picture.width, window.frame.size.width * 0.85);
    CGFloat availableHeight = MIN(imageMessage.picture.height, window.frame.size.height * 0.85);
    CGFloat ratio = MIN(availableWidth / imageMessage.picture.width, availableHeight / imageMessage.picture.height);

    CGFloat width = imageMessage.picture.width * ratio;
    CGFloat height = imageMessage.picture.height * ratio;
    CGFloat left = (window.frame.size.width - width) / 2;
    CGFloat top = (window.frame.size.height - height) / 2;

    CGRect rect = CGRectMake(left, top, width, height);

    [view removeFromSuperview];

    self.view = [[UIView alloc] initWithFrame:window.frame];
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [window addSubview:view];

    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicatorView.frame = window.frame;
    [activityIndicatorView startAnimating];
    [window addSubview:activityIndicatorView];

    [self cacheImages:^{

        [self showImageWithRect:rect ratio:ratio];
        [self showScreenButtonWithRect:rect ratio:ratio];
        [self showImageButtonsWithRect:rect ratio:ratio];
        [self showCloseButtonWithRect:rect ratio:ratio];

        [self.activityIndicatorView removeFromSuperview];
        self.activityIndicatorView = nil;

    }];

}

- (void) showImageWithRect:(CGRect)rect ratio:(CGFloat)ratio {

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];

    imageView.image = [cachedImages objectForKey:imageMessage.picture.url];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.userInteractionEnabled = YES;
    [view addSubview:imageView];

}

- (void) showScreenButtonWithRect:(CGRect)rect ratio:(CGFloat)ratio {

    GMScreenButton *screenButton = [[self extractButtonsWithType:GMButtonTypeScreen] lastObject];

    if (!screenButton) {
        return;
    }

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[cachedImages objectForKey:imageMessage.picture.url] forState:UIControlStateNormal];
    button.contentMode = UIViewContentModeScaleAspectFit;
    button.frame = rect;
    [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];

    [boundButtons setObject:screenButton forKey:[NSValue valueWithNonretainedObject:button]];

}

- (void) showImageButtonsWithRect:(CGRect)rect ratio:(CGFloat)ratio {

    NSArray *imageButtons = [self extractButtonsWithType:GMButtonTypeImage];

    CGFloat top = rect.origin.y + rect.size.height;

    for (GMImageButton *imageButton in [imageButtons reverseObjectEnumerator]) {

        CGFloat width = imageButton.picture.width * ratio;
        CGFloat height = imageButton.picture.height * ratio;
        CGFloat left = rect.origin.x + (rect.size.width - width) / 2;
        top -= height;

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[cachedImages objectForKey:imageButton.picture.url] forState:UIControlStateNormal];
        button.contentMode = UIViewContentModeScaleAspectFit;
        button.frame = CGRectMake(left, top, width, height);
        [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];

        [boundButtons setObject:imageButton forKey:[NSValue valueWithNonretainedObject:button]];

    }

}

- (void) showCloseButtonWithRect:(CGRect)rect ratio:(CGFloat)ratio {

    GMCloseButton *closeButton = [[self extractButtonsWithType:GMButtonTypeClose] lastObject];

    if (!closeButton) {
        return;
    }

    CGFloat width = closeButton.picture.width * ratio;
    CGFloat height = closeButton.picture.height * ratio;
    CGFloat left = rect.origin.x + rect.size.width - width / 2;
    CGFloat top = rect.origin.y - height / 2;

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[cachedImages objectForKey:closeButton.picture.url] forState:UIControlStateNormal];
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

- (void) cacheImages:(void (^)(void))callback {

    NSMutableArray *urlStrings = [NSMutableArray array];

    if (imageMessage.picture.url) {
        [urlStrings addObject:imageMessage.picture.url];
    }

    for (GMButton *button in imageMessage.buttons) {
        switch (button.type) {
            case GMButtonTypeImage:
                if (((GMImageButton *)button).picture.url) {
                    [urlStrings addObject:((GMImageButton *)button).picture.url];
                }
                break;
            case GMButtonTypeClose:
                if (((GMCloseButton *)button).picture.url) {
                    [urlStrings addObject:((GMCloseButton *)button).picture.url];
                }
                break;
            default:
                continue;
        }
    }

    for (NSString *urlString in urlStrings) {
        [self cacheImageWithUrlString:urlString completion:^(NSString *urlString){
            [urlStrings removeObject:urlString];
            if ([urlStrings count] == 0 && callback) {
                callback();
            }
        }];
    }

}

- (void) cacheImageWithUrlString:(NSString *)urlString completion:(void (^)(NSString *urlString))completion {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        if([cachedImages objectForKey:urlString]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(urlString);
                }
            });
            return;
        }

        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];

        dispatch_async(dispatch_get_main_queue(), ^{
            if (image) {
                [cachedImages setObject:image forKey:urlString];
            }
            if (completion) {
                completion(urlString);
            }
        });

    });

}

- (void) tapButton:(id)sender {

    GMButton *button = [boundButtons objectForKey:[NSValue valueWithNonretainedObject:sender]];

    [self.view removeFromSuperview];
    self.view = nil;
    self.boundButtons = nil;

    [delegate clickedButton:button message:imageMessage];

}

@end
