//
//  GMPlainButton.h
//  GrowthMessage
//
//  Created by Naoyuki Kataoka on 2015/03/17.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import <GrowthMessage/GrowthMessage.h>

@interface GMPlainButton : GMButton <NSCoding> {
    
    NSString *label;
    
}

@property (nonatomic, strong) NSString *label;

@end
