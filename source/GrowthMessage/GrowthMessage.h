//
//  GrowthMessage.h
//  GrowthMessage
//
//  Created by Naoyuki Kataoka on 2015/03/02.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GrowthbeatCore.h"
#import "GrowthMessageDelegate.h"
#import "GMMessageHandler.h"

@interface GrowthMessage : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, assign) id<GrowthMessageDelegate> delegate;
@property (nonatomic, strong) NSArray *messageHandlers;

- (void)initializeWithApplicationId:(NSString *)applicationId credentialId:(NSString *)credentialId;

- (void)openMessageIfAvailable;

- (GBLogger *)logger;
- (GBHttpClient *)httpClient;
- (GBPreference *)preference;


@end
