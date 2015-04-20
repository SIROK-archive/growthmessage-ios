//
//  GMImageMessageRenderer.h
//  GrowthMessage
//
//  Created by Naoyuki Kataoka on 2015/04/21.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMImageMessage.h"

@interface GMImageMessageRenderer : NSObject {
    
    GMImageMessage *imageMessage;
    
}

@property (nonatomic, strong) GMImageMessage *imageMessage;

- (instancetype)initWithImageMessage:(GMImageMessage *)newImageMessage;
- (void)show;

@end
