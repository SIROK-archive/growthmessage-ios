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

@implementation GMMessage

@synthesize id;
@synthesize format;
@synthesize data;
@synthesize buttons;
@synthesize created;

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

#pragma mark --
#pragma mark NSCoding

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
	if (self) {
		if ([aDecoder containsValueForKey:@"id"]) {
			self.id = [aDecoder decodeObjectForKey:@"id"];
		}
		if ([aDecoder containsValueForKey:@"format"]) {
			self.format = [aDecoder decodeObjectForKey:@"format"];
		}
		if ([aDecoder containsValueForKey:@"data"]) {
			self.data = [aDecoder decodeObjectForKey:@"data"];
		}
        if ([aDecoder containsValueForKey:@"created"]) {
            self.created = [aDecoder decodeObjectForKey:@"created"];
        }
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:id forKey:@"id"];
	[aCoder encodeObject:format forKey:@"format"];
	[aCoder encodeObject:data forKey:@"data"];
	[aCoder encodeObject:buttons forKey:@"buttons"];
    [aCoder encodeObject:created forKey:@"created"];
}

+ (id)domainWithDictionary:(NSDictionary *)dictionary {
	NSError *error = nil;
	GMMessage *message = [[GMMessage alloc] init];
	message.id = [dictionary objectForKey:@"id"];
	message.format = [dictionary objectForKey:@"format"];
	message.data = [NSJSONSerialization JSONObjectWithData:[(NSString*)[dictionary objectForKey:@"data"] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
	if (error) {
		[[[GrowthMessage sharedInstance] logger] error:@"parsing error %@", error];
		message = nil;
	}
	
	NSMutableArray *buttons = [NSMutableArray array];
	for (NSDictionary *buttonData in [message.data objectForKey:@"buttons"]) {
		GMButton *button = [GMButton domainWithDictionary:buttonData];
		[buttons addObject:button];
	}
	message.buttons = [buttons copy];
	
	return message;
}
@end
