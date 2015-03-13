//
//  GMIntent.m
//  GrowthMessage
//
//  Created by 堀内 暢之 on 2015/03/08.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "GMIntent.h"

@implementation GMIntent
@synthesize action;
@synthesize data;

#pragma mark --
#pragma mark NSCoding

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
	self = [super init];
	if (self) {
		if ([aDecoder containsValueForKey:@"action"]) {
			self.action = [aDecoder decodeObjectForKey:@"action"];
		}
		if ([aDecoder containsValueForKey:@"data"]) {
			self.data = [aDecoder decodeObjectForKey:@"data"];
		}
	}
	return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:action forKey:@"action"];
	[aCoder encodeObject:data forKey:@"data"];
}

+ (id)domainWithDictionary:(NSDictionary *)dictionary {
	GMIntent *intent = [[GMIntent alloc] init];
	
	intent.action = [dictionary objectForKey:@"action"];
	intent.data = [dictionary objectForKey:@"data"];
	
	return intent;
}

@end
