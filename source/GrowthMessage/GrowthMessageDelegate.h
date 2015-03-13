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

// this is, for example, to prevent an message showing up while playing game;
- (BOOL)shouldShowMessage:(GMMessage*)message manager:(GrowthMessage*)manager;

@end