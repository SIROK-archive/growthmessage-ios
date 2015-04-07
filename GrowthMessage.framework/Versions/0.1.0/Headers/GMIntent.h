//
//  GMIntent.h
//  GrowthMessage
//
//  Created by 堀内 暢之 on 2015/03/08.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "GBDomain.h"

@interface GMIntent : GBDomain <NSCoding> {
	NSString *action;
	NSDictionary *data;
}
@property (nonatomic, strong) NSString *action;
@property (nonatomic, strong) NSDictionary *data;
@end
