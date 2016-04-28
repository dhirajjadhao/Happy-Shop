//
//  webService.m
//  Happy Shop
//
//  Created by Dhiraj Jadhao on 17/04/16.
//  Copyright © 2016 Dhiraj Jadhao. All rights reserved.
//

#import "webService.h"

@implementation webService

-(void)sendRequest:(NSString*)url parameter:(id)parameters requestType:(NSString*)type :(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:60.0];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];


    [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];


    
    if ([type isEqualToString:@"GET"]){
        if (parameters != nil){
            [manager GET:url parameters:parameters success:success failure:failure];
        }
        else{
            
            [manager GET:url parameters:nil success:success failure:failure];
        }
    }
    
    else if ([type isEqualToString:@"DELETE"]){
        
        manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil];
        if (parameters != nil){
            [manager DELETE:url parameters:parameters success:success failure:failure];
        }
        else{
            [manager DELETE:url parameters:nil success:success failure:failure];
        }
        
    }
    
    else if ([type isEqualToString:@"PUT"]){
        [manager PUT:url parameters:parameters success:success failure:failure];
    }
    
    else{
        if (parameters != nil){
            [manager POST:url parameters:parameters success:success failure:failure];
        }
        else{
          
            [manager POST:url parameters:nil success:success failure:failure];
        }
    }
}




-(void)sendRequestURLEncoded:(NSString*)url parameter:(id)parameters requestType:(NSString*)type :(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:60];
    
    [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
  
    
    if ([type isEqualToString:@"GET"]){
        if (parameters != nil){
            [manager GET:url parameters:parameters success:success failure:failure];
        }
        else{
            
            [manager GET:url parameters:nil success:success failure:failure];
        }
        
    }
    
    else if ([type isEqualToString:@"DELETE"]){
        manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil];
        if (parameters != nil){
            [manager DELETE:url parameters:parameters success:success failure:failure];
        }
        else{
            [manager DELETE:url parameters:nil success:success failure:failure];
        }
        
    }
    
    else if ([type isEqualToString:@"PUT"]){
        [manager PUT:url parameters:parameters success:success failure:failure];
    }
    
    else{
        if (parameters != nil){
            [manager POST:url parameters:parameters success:success failure:failure];
        }
        else{
            [manager POST:url parameters:nil success:success failure:failure];
        }
    }
    
}



@end
