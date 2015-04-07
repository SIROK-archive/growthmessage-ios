//
//  GrowthMessageDelegate.h
//  GrowthMessage
//
//  Created by 堀内 暢之 on 2015/03/03.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "GMMessage.h"

@class GrowthMessage;

@protocol GrowthMessageDelegate <NSObject>

- (BOOL)shouldShowMessage:(GMMessage *)message;

@end