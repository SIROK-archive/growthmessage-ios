//
//  GMButton.h
//  GrowthMessage
//
//  Created by 堀内 暢之 on 2015/03/03.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "GBDomain.h"
#import "GBIntent.h"
#import "GMButtonType.h"

@interface GMButton : GBDomain <NSCoding> {

    NSString *id;
    GMButtonType type;
    NSDate *created;
	GBIntent *intent;
	
}

@property (nonatomic, strong) NSString *id;
@property (nonatomic, assign) GMButtonType type;
@property (nonatomic, strong) NSDate *created;
@property (nonatomic, strong) GBIntent *intent;
@end
