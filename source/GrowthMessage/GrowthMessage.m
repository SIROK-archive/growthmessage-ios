//
//  GrowthMessage.m
//  GrowthMessage
//
//  Created by Naoyuki Kataoka on 2015/03/02.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "GrowthMessage.h"
#import "GrowthAnalytics.h"
#import "GMMessage.h"
#import "GMMessageHandler.h"
#import "GMBasicMessageHandler.h"

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

- (void)openMessage:(GMMessage*)message;

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
    
    [[GrowthAnalytics sharedInstance] initializeWithApplicationId:applicationId credentialId:credentialId];
    [[GrowthAnalytics sharedInstance] addEventHandler:[[GAEventHandler alloc] initWithCallback:^(NSString *eventId, NSDictionary *properties) {
        [self openMessageIfAvailableWithEventId:eventId];
    }]];
    
    self.messageHandlers = [NSArray arrayWithObjects:[[GMBasicMessageHandler alloc] init], nil];
    
}

- (void)openMessageIfAvailableWithEventId:(NSString*)eventId {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        [logger info:@"Check message..."];
        
		GMMessage *message = [GMMessage findWithClientId:[[[GrowthbeatCore sharedInstance] waitClient] id] credentialId:credentialId eventId:eventId];
		if(message) {
			[logger info:@"Message is found. (id: %@)", message.id];
			dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
				[self openMessage: message];
			});
        } else {
            [logger info:@"Message is not found."];
        }
        
    });

}

- (void)openMessage:(GMMessage*)message {
	__weak typeof(self) __weak_self = self;
	if ((! __weak_self.delegate) || [__weak_self.delegate shouldShowMessage:message manager:__weak_self]) {
		for (id<GMMessageHandler> handler in __weak_self.messageHandlers) {
			if ([handler handleMessage:message manager:__weak_self]) {
				//showed?
				break;
			} else {
				//not handled by the handler, continue...
			}
		}
	} else {
		[logger info:@"Message is found. (id: %@)", message.id];
	}
}

- (void)didSelectButton:(GMButton *)button message:(GMMessage *)message {
    
    [[GrowthbeatCore sharedInstance] handleIntent:button.intent];
    
    NSString *eventId = [NSString stringWithFormat:@"Event:%@:GrowthMessage:SelectButton", applicationId];
    NSDictionary *properties = @{
        @"messageId": message.id,
        @"buttonId": button.id
    };
    [[GrowthAnalytics sharedInstance] track:eventId properties:properties];
    
}

@end
