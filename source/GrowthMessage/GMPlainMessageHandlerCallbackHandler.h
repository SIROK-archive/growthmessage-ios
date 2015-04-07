//
//  GMPlainMessageHandlerCallbackHandler.h
//  GrowthMessage
//
//  Created by Naoyuki Kataoka on 2015/04/07.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMPlainMessage.h"

@interface GMPlainMessageHandlerCallbackHandler : NSObject <UIAlertViewDelegate> {
    
    GMPlainMessage *plainMessage;
    
}

@property (nonatomic, strong) GMPlainMessage *plainMessage;

- (instancetype)initWithPlainMessage:(GMPlainMessage *)newPlainMessage;

@end
