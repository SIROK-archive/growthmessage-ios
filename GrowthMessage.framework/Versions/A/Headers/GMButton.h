//
//  GMButton.h
//  GrowthMessage
//
//  Created by 堀内 暢之 on 2015/03/03.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "GBDomain.h"
#import "GMIntent.h"

@interface GMButton : GBDomain <NSCoding> {

	NSString *label;
	GMIntent *intent;
	NSString *event;
	
}

@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) GMIntent *intent;
@property (nonatomic, strong) NSString *event;

@end
