//
//  GMMessage.h
//  GrowthMessage
//
//  Created by Naoyuki Kataoka on 2015/03/02.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "GBDomain.h"
#import "GMTask.h"

@interface GMMessage : GBDomain <NSCoding> {
    
    NSString *id;
	NSString *format;
	NSDictionary *data;
	NSArray *buttons;
    NSDate *created;
    GMTask *task;
    
}

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *format;
@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, strong) NSArray *buttons;
@property (nonatomic, strong) NSDate *created;
@property (nonatomic, strong) GMTask *task;

+ (instancetype)findWithClientId:(NSString *)clientId credentialId:(NSString *)credentialId eventId:(NSString *)eventId;

@end
