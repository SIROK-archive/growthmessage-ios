//
//  GMIntentHandler.h
//  GrowthMessage
//
//  Created by 堀内 暢之 on 2015/03/08.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//


#import "GMIntent.h"

@protocol GMIntentHandler <NSObject>

- (BOOL)handleIntent:(GMIntent*)intent;

@end