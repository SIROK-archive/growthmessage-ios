//
//  GrowthMessage.h
//  GrowthMessage
//
//  Created by Naoyuki Kataoka on 2015/03/02.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GrowthbeatCore.h"

@interface GrowthMessage : NSObject

+ (instancetype)sharedInstance;

- (void)initializeWithApplicationId:(NSString *)applicationId credentialId:(NSString *)credentialId;

- (void)openMessageIfAvailable;

- (GBLogger *)logger;
- (GBHttpClient *)httpClient;
- (GBPreference *)preference;


@end
