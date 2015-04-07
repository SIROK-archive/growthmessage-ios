//
//  AppDelegate.m
//  GrowthMessageSample
//
//  Created by Naoyuki Kataoka on 2015/03/02.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "AppDelegate.h"
#import <GrowthMessage/GrowthMessage.h>
#import <GrowthAnalytics/GrowthAnalytics.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[GrowthMessage sharedInstance] initializeWithApplicationId:@"P5C3vzoLOEijnlVj" credentialId:@"btFlFAitBJ1CBdL3IR3ROnhLYbeqmLlY"];

    return YES;

}

- (void) applicationDidBecomeActive:(UIApplication *)application {
    [[GrowthAnalytics sharedInstance] open];
}

- (void) applicationWillResignActive:(UIApplication *)application {
    [[GrowthAnalytics sharedInstance] close];
}

@end
