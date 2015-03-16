//
//  GMMessage.h
//  GrowthMessage
//
//  Created by Naoyuki Kataoka on 2015/03/02.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "GBDomain.h"
#import "GMTask.h"
#import "GMMessageType.h"

@interface GMMessage : GBDomain <NSCoding> {
    
    NSString *id;
	NSInteger version;
    NSString *name;
    GMMessageType type;
    NSDictionary *extra;
    NSString *eventId;
    NSString *segmentId;
    NSDate *availableFrom;
    NSDate *availableTo;
    NSDate *created;
    GMTask *task;
    
}

@property (nonatomic, strong) NSString *id;
@property (nonatomic, assign) NSInteger version;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) GMMessageType type;
@property (nonatomic, strong) NSDictionary *extra;
@property (nonatomic, strong) NSString *eventId;
@property (nonatomic, strong) NSString *segmentId;
@property (nonatomic, strong) NSDate *availableFrom;
@property (nonatomic, strong) NSDate *availableTo;
@property (nonatomic, strong) NSDate *created;
@property (nonatomic, strong) GMTask *task;

+ (instancetype)findWithClientId:(NSString *)clientId credentialId:(NSString *)credentialId eventId:(NSString *)eventId;

@end
