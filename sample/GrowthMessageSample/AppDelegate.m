//
//  AppDelegate.m
//  GrowthMessageSample
//
//  Created by Naoyuki Kataoka on 2015/03/02.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "AppDelegate.h"
#import <GrowthAnalytics/GrowthAnalytics.h>
#import <GrowthbeatCore/GrowthbeatCore.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[GrowthMessage sharedInstance] initializeWithApplicationId:@"P5C3vzoLOEijnlVj" credentialId:@"btFlFAitBJ1CBdL3IR3ROnhLYbeqmLlY"];
    [[[GrowthMessage sharedInstance] httpClient] setBaseUrl:[NSURL URLWithString:@"http://api.stg.message.growthbeat.com/"]];
	
	[[GrowthAnalytics sharedInstance] initializeWithApplicationId:@"P5C3vzoLOEijnlVj" credentialId:@"btFlFAitBJ1CBdL3IR3ROnhLYbeqmLlY"];
	[[GrowthAnalytics sharedInstance] setBasicTags];
	
	[[GrowthAnalytics sharedInstance] setUserId:@"USER_ID"];
	[[GrowthAnalytics sharedInstance] setAge:25];
	[[GrowthAnalytics sharedInstance] setGender:YES];
	[[GrowthAnalytics sharedInstance] setLevel:10];
	
	NSLog(@"client id: %@", [[[GrowthbeatCore sharedInstance] waitClient] id]);
    
    return YES;
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[GrowthAnalytics sharedInstance] open];
}

- (void)applicationWillResignActive:(UIApplication *)application {
	[[GrowthAnalytics sharedInstance] close];
}

@end
