//
//  GMMessage.m
//  GrowthMessage
//
//  Created by Naoyuki Kataoka on 2015/03/02.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "GMMessage.h"
#import "GBUtils.h"
#import "GBHttpClient.h"
#import "GrowthMessage.h"
#import "GMPlainMessage.h"
#import "GMImageMessage.h"

@implementation GMMessage

@synthesize id;
@synthesize version;
@synthesize name;
@synthesize type;
@synthesize eventId;
@synthesize segmentId;
@synthesize availableFrom;
@synthesize availableTo;
@synthesize created;
@synthesize task;
@synthesize buttons;

+ (instancetype)findWithClientId:(NSString *)clientId credentialId:(NSString *)credentialId eventId:(NSString *)eventId {
    
    NSString *path = @"/0/message";
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    
    if (clientId) {
        [body setObject:clientId forKey:@"clientId"];
    }
    if (credentialId) {
        [body setObject:credentialId forKey:@"credentialId"];
    }
	if (eventId) {
		[body setObject:eventId forKey:@"eventId"];
	}
    
    GBHttpRequest *httpRequest = [GBHttpRequest instanceWithMethod:GBRequestMethodPost path:path query:nil body:body];
    GBHttpResponse *httpResponse = [[[GrowthMessage sharedInstance] httpClient] httpRequest:httpRequest];
    if(!httpResponse.success){
        [[[GrowthMessage sharedInstance] logger] error:@"Failed to find message. %@", httpResponse.error?httpResponse.error:[httpResponse.body objectForKey:@"message"]];
        return nil;
	} else if (! httpResponse.body) {
		[[[GrowthMessage sharedInstance] logger] info:@"message not available"];
		return nil;
	} else {
		[[[GrowthMessage sharedInstance] logger] info:@"got a message %@", httpResponse.body];
	}
	
    return [GMMessage domainWithDictionary:httpResponse.body];
    
}

+ (instancetype)domainWithDictionary:(NSDictionary *)dictionary {
    
    GMMessage *message = [[self alloc] initWithDictionary:dictionary];
    switch (message.type) {
        case GMMessageTypePlain:
            if([message isKindOfClass:[GMPlainMessage class]])
                return message;
            else
                return [GMPlainMessage domainWithDictionary:dictionary];
        case GMMessageTypeImage:
            if([message isKindOfClass:[GMImageMessage class]])
                return message;
            else
                return [GMImageMessage domainWithDictionary:dictionary];
        default:
            return nil;
    }
    
}

- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        if ([dictionary objectForKey:@"id"] && [dictionary objectForKey:@"id"] != [NSNull null]) {
            self.id = [dictionary objectForKey:@"id"];
        }
        if ([dictionary objectForKey:@"version"] && [dictionary objectForKey:@"version"] != [NSNull null]) {
            self.version = [[dictionary objectForKey:@"version"] integerValue];
        }
        if ([dictionary objectForKey:@"name"] && [dictionary objectForKey:@"name"] != [NSNull null]) {
            self.name = [dictionary objectForKey:@"name"];
        }
        if ([dictionary objectForKey:@"type"] && [dictionary objectForKey:@"type"] != [NSNull null]) {
            self.type = GMMessageTypeFromNSString([dictionary objectForKey:@"type"]);
        }
        if ([dictionary objectForKey:@"eventId"] && [dictionary objectForKey:@"eventId"] != [NSNull null]) {
            self.eventId = [dictionary objectForKey:@"eventId"];
        }
        if ([dictionary objectForKey:@"segmentId"] && [dictionary objectForKey:@"segmentId"] != [NSNull null]) {
            self.segmentId = [dictionary objectForKey:@"segmentId"];
        }
        if ([dictionary objectForKey:@"availableFrom"] && [dictionary objectForKey:@"availableFrom"] != [NSNull null]) {
            self.availableFrom = [dictionary objectForKey:@"availableFrom"];
        }
        if ([dictionary objectForKey:@"availableTo"] && [dictionary objectForKey:@"availableTo"] != [NSNull null]) {
            self.availableTo = [dictionary objectForKey:@"availableTo"];
        }
        if ([dictionary objectForKey:@"created"] && [dictionary objectForKey:@"created"] != [NSNull null]) {
            self.created = [dictionary objectForKey:@"created"];
        }
        if ([dictionary objectForKey:@"task"] && [dictionary objectForKey:@"task"] != [NSNull null]) {
            self.task = [GMTask domainWithDictionary:[dictionary objectForKey:@"task"]];
        }
        if ([dictionary objectForKey:@"buttons"] && [dictionary objectForKey:@"buttons"] != [NSNull null]) {
            NSMutableArray *newButtons = [NSMutableArray array];
            for (NSDictionary *buttonDictionary in [dictionary objectForKey:@"buttons"]) {
                [newButtons addObject:[GMButton domainWithDictionary:buttonDictionary]];
            }
            self.buttons = newButtons;
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
		if ([aDecoder containsValueForKey:@"version"]) {
			self.version = [aDecoder decodeIntegerForKey:@"version"];
        }
        if ([aDecoder containsValueForKey:@"name"]) {
            self.name = [aDecoder decodeObjectForKey:@"name"];
        }
        if ([aDecoder containsValueForKey:@"type"]) {
            self.type = [aDecoder decodeIntegerForKey:@"type"];
        }
        if ([aDecoder containsValueForKey:@"eventId"]) {
            self.eventId = [aDecoder decodeObjectForKey:@"eventId"];
        }
        if ([aDecoder containsValueForKey:@"segmentId"]) {
            self.segmentId = [aDecoder decodeObjectForKey:@"segmentId"];
        }
        if ([aDecoder containsValueForKey:@"availableFrom"]) {
            self.availableFrom = [aDecoder decodeObjectForKey:@"availableFrom"];
        }
        if ([aDecoder containsValueForKey:@"availableTo"]) {
            self.availableTo = [aDecoder decodeObjectForKey:@"availableTo"];
        }
        if ([aDecoder containsValueForKey:@"created"]) {
            self.created = [aDecoder decodeObjectForKey:@"created"];
        }
        if ([aDecoder containsValueForKey:@"task"]) {
            self.task = [GMTask domainWithDictionary:[aDecoder decodeObjectForKey:@"task"]];
        }
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:id forKey:@"id"];
	[aCoder encodeInteger:version forKey:@"version"];
	[aCoder encodeObject:name forKey:@"name"];
    [aCoder encodeInteger:type forKey:@"type"];
    [aCoder encodeObject:eventId forKey:@"eventId"];
    [aCoder encodeObject:segmentId forKey:@"segmentId"];
    [aCoder encodeObject:availableFrom forKey:@"availableFrom"];
    [aCoder encodeObject:availableTo forKey:@"availableTo"];
    [aCoder encodeObject:created forKey:@"created"];
    [aCoder encodeObject:task forKey:@"task"];
}


@end
