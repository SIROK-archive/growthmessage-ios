//
//  GrowthMessage.m
//  GrowthMessage
//
//  Created by Naoyuki Kataoka on 2015/03/02.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "GrowthMessage.h"
#import "GMMessage.h"
#import "GMMessageHandler.h"

static GrowthMessage *sharedInstance = nil;
static NSString *const kGBLoggerDefaultTag = @"GrowthMessage";
static NSString *const kGBHttpClientDefaultBaseUrl = @"https://api.message.growthbeat.com/";
static NSString *const kGBPreferenceDefaultFileName = @"growthmessage-preferences";

@interface GrowthMessage () {
    
    GBLogger *logger;
    GBHttpClient *httpClient;
    GBPreference *preference;
    
    NSString *applicationId;
    NSString *credentialId;
    
}

@property (nonatomic, strong) GBLogger *logger;
@property (nonatomic, strong) GBHttpClient *httpClient;
@property (nonatomic, strong) GBPreference *preference;

@property (nonatomic, strong) NSString *applicationId;
@property (nonatomic, strong) NSString *credentialId;

@end

@implementation GrowthMessage

@synthesize delegate;
@synthesize messageHandlers;

@synthesize logger;
@synthesize httpClient;
@synthesize preference;

@synthesize applicationId;
@synthesize credentialId;

+ (instancetype)sharedInstance {
    @synchronized(self) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 5.0f) {
            return nil;
        }
        if (!sharedInstance) {
            sharedInstance = [[self alloc] init];
        }
        return sharedInstance;
    }
}

- (id)init {
    self = [super init];
    if (self) {
        self.logger = [[GBLogger alloc] initWithTag:kGBLoggerDefaultTag];
        self.httpClient = [[GBHttpClient alloc] initWithBaseUrl:[NSURL URLWithString:kGBHttpClientDefaultBaseUrl]];
        self.preference = [[GBPreference alloc] initWithFileName:kGBPreferenceDefaultFileName];
    }
    return self;
}

- (void)initializeWithApplicationId:(NSString *)newApplicationId credentialId:(NSString *)newCredentialId {
    
    self.applicationId = newApplicationId;
    self.credentialId = newCredentialId;
    
    [[GrowthbeatCore sharedInstance] initializeWithApplicationId:applicationId credentialId:credentialId];
    
}

- (void)openMessageIfAvailable {
	__weak typeof(self) __weak_self = self;
	
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        [logger info:@"Check message..."];
        
        GMMessage *message = [GMMessage findWithClientId:[[[GrowthbeatCore sharedInstance] waitClient] id] credentialId:credentialId];
        if(message) {
            [logger info:@"Message is found. (id: %@)", message.token];
            
            // TODO Show message dialog
			if ((! __weak_self.delegate) || [__weak_self.delegate shoudShowMessage:message]) {
				for (id<GMMessageHandler> handler in __weak_self.messageHandlers) {
					if ([handler handleMessage:message]) {
						//showed?
						break;
					} else {
						//not handled by the handler, continue...
					}
				}
			} else {
				[logger info:@"Message is found. (id: %@)", message.token];
			}
        } else {
            [logger info:@"Message is not found."];
        }
        
    });

}

@end
