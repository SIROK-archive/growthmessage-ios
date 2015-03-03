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

@synthesize token;
@synthesize title;
@synthesize body;
@synthesize buttons;
@synthesize created;

+ (instancetype)findWithClientId:(NSString *)clientId credentialId:(NSString *)credentialId {
    
    NSString *path = @"/1/messages";
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    
    if (clientId) {
        [body setObject:clientId forKey:@"clientId"];
    }
    if (credentialId) {
        [body setObject:credentialId forKey:@"credentialId"];
    }
    
    GBHttpRequest *httpRequest = [GBHttpRequest instanceWithMethod:GBRequestMethodPost path:path query:nil body:body];
    GBHttpResponse *httpResponse = [[[GrowthMessage sharedInstance] httpClient] httpRequest:httpRequest];
    if(!httpResponse.success){
        [[[GrowthMessage sharedInstance] logger] error:@"Failed to find message. %@", httpResponse.error?httpResponse.error:[httpResponse.body objectForKey:@"message"]];
        return nil;
    }
    
    return [GMMessage domainWithDictionary:httpResponse.body];
    
}

#pragma mark --
#pragma mark NSCoding

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
	if (self) {
		if ([aDecoder containsValueForKey:@"token"]) {
			self.token = [aDecoder decodeObjectForKey:@"token"];
		}
		if ([aDecoder containsValueForKey:@"title"]) {
			self.title = [aDecoder decodeObjectForKey:@"title"];
		}
		if ([aDecoder containsValueForKey:@"body"]) {
			self.body = [aDecoder decodeObjectForKey:@"body"];
		}
		if ([aDecoder containsValueForKey:@"buttons"]) {
			self.buttons = [aDecoder decodeObjectForKey:@"buttons"];
		}
        if ([aDecoder containsValueForKey:@"created"]) {
            self.created = [aDecoder decodeObjectForKey:@"created"];
        }
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:token forKey:@"token"];
	[aCoder encodeObject:title forKey:@"title"];
	[aCoder encodeObject:body forKey:@"body"];
	[aCoder encodeObject:buttons forKey:@"buttons"];
    [aCoder encodeObject:created forKey:@"created"];
}

@end
