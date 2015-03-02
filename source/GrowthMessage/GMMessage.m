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
        if ([aDecoder containsValueForKey:@"id"]) {
            self.id = [aDecoder decodeObjectForKey:@"id"];
        }
        if ([aDecoder containsValueForKey:@"created"]) {
            self.created = [aDecoder decodeObjectForKey:@"created"];
        }
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:id forKey:@"id"];
    [aCoder encodeObject:created forKey:@"created"];
}

@end
