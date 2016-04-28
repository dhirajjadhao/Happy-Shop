//
//  webService.h
//  Happy Shop
//
//  Created by Dhiraj Jadhao on 17/04/16.
//  Copyright © 2016 Dhiraj Jadhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface webService : NSObject

-(void)sendRequestURLEncoded:(NSString*)url parameter:(id)parameters requestType:(NSString*)type :(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

-(void)sendRequest:(NSString*)url parameter:(id)parameters requestType:(NSString*)type :(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
