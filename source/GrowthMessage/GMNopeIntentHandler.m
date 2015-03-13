//
//  GMNopeIntentHandler.m
//  GrowthMessage
//
//  Created by 堀内 暢之 on 2015/03/08.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "GMNopeIntentHandler.h"

@implementation GMNopeIntentHandler
- (BOOL)handleIntent:(GMIntent *)intent {
	if ([intent.action isEqualToString:@"nope"]) {
		return YES;
	} else {
		return NO;
	}
}
@end
