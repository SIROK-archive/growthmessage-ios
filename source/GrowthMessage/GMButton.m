//
//  GMButton.m
//  GrowthMessage
//
//  Created by 堀内 暢之 on 2015/03/03.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "GMButton.h"
#import "GBIntent.h"

@implementation GMButton

@synthesize id;
@synthesize label;
@synthesize intent;
@synthesize event;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        if ([dictionary objectForKey:@"id"] && [dictionary objectForKey:@"id"] != [NSNull null]) {
            self.id = [dictionary objectForKey:@"id"];
        }
        if ([dictionary objectForKey:@"label"] && [dictionary objectForKey:@"label"] != [NSNull null]) {
            self.label = [dictionary objectForKey:@"label"];
        }
        if ([dictionary objectForKey:@"event"] && [dictionary objectForKey:@"event"] != [NSNull null]) {
            self.event = [dictionary objectForKey:@"event"];
        }
        if ([dictionary objectForKey:@"intent"] && [dictionary objectForKey:@"intent"] != [NSNull null]) {
            self.intent = [GBIntent domainWithDictionary:[dictionary objectForKey:@"intent"]];
        }
    }
    return self;
    
}

#pragma mark --
#pragma mark NSCoding

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
	self = [super init];
    if (self) {
        if ([aDecoder containsValueForKey:@"id"]) {
            self.id = [aDecoder decodeObjectForKey:@"id"];
        }
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
    [aCoder encodeObject:id forKey:@"id"];
    [aCoder encodeObject:label forKey:@"label"];
	[aCoder encodeObject:intent forKey:@"intent"];
	[aCoder encodeObject:event forKey:@"event"];
}

@end
