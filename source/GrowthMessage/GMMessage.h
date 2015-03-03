//
//  GMMessage.h
//  GrowthMessage
//
//  Created by Naoyuki Kataoka on 2015/03/02.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "GBDomain.h"

@interface GMMessage : GBDomain <NSCoding> {
    
    NSString *token;
	NSString *title;
	NSString *body;
	NSArray *buttons;
    NSDate *created;
    
}

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSArray *buttons;
@property (nonatomic, strong) NSDate *created;

+ (instancetype)findWithClientId:(NSString *)clientId credentialId:(NSString *)credentialId;

@end
