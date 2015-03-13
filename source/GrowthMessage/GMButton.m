//
//  GMButton.m
//  GrowthMessage
//
//  Created by 堀内 暢之 on 2015/03/03.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "GMButton.h"
#import "GMIntent.h"

@implementation GMButton

@synthesize label;
@synthesize intent;
@synthesize event;

#pragma mark --
#pragma mark NSCoding

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
	self = [super init];
	if (self) {
		if ([aDecoder containsValueForKey:@"label"]) {
			self.label = [aDecoder decodeObjectForKey:@"label"];
		}
		if ([aDecoder containsValueForKey:@"intent"]) {
			self.intent = [aDecoder decodeObjectForKey:@"intent"];
		}
		if ([aDecoder containsValueForKey:@"event"]) {
			self.event = [aDecoder decodeObjectForKey:@"event"];
		}
	}
	return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:label forKey:@"label"];
	[aCoder encodeObject:intent forKey:@"intent"];
	[aCoder encodeObject:event forKey:@"event"];
}

+ (id)domainWithDictionary:(NSDictionary *)dictionary {
	GMButton *button = [[GMButton alloc] init];
	button.label = [dictionary objectForKey:@"label"];
	button.event = [dictionary objectForKey:@"event"];
	button.intent = [GMIntent domainWithDictionary:dictionary];
	return button;
}
@end
