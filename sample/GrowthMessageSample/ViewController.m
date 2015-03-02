//
//  ViewController.m
//  GrowthMessageSample
//
//  Created by Naoyuki Kataoka on 2015/03/02.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "ViewController.h"
#import <GrowthMessage/GrowthMessage.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[GrowthMessage sharedInstance] openMessageIfAvailable];
}

@end
