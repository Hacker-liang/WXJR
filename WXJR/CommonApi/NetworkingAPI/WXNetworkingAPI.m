//
//  WXNetworkingAPI.m
//  WXJR
//
//  Created by liangpengshuai on 8/31/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

#import "WXNetworkingAPI.h"
#import "WXJR-swift.h"
#import "NSString+UrlEncodeing.h"

@implementation WXNetworkingAPI

+ (void)GET:(NSString *)URLString params:(NSDictionary *)params completionBlock:(void(^)(id responseObject, NSError *error))completionBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    if ([[WXAccountManager shareInstance] userIsLoginIn]) {
//        NSLog(@"access_token: %@", [WXAccountManager shareInstance].accountDetail.access_token);
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", [WXAccountManager shareInstance].accountDetail.access_token] forHTTPHeaderField:@"Authorization"];
    }
    
    [manager GET:URLString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject success: %@", responseObject);
        completionBlock(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"responseObject failure: %@", error);
        completionBlock(nil, error);
    }];
    
}

+ (void)POST:(NSString *)URLString params:(NSDictionary *)params completionBlock:(void(^)(id responseObject, NSError *error))completionBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    if ([[WXAccountManager shareInstance] userIsLoginIn]) {
        NSLog(@"access_token: %@", [WXAccountManager shareInstance].accountDetail.access_token);
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", [WXAccountManager shareInstance].accountDetail.access_token] forHTTPHeaderField:@"Authorization"];
    }
    [manager POST:URLString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject success: %@", responseObject);
        completionBlock(responseObject, nil);

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"responseObject failure: %@", error);
        completionBlock(nil, error);

    }];
}

+ (void)POST:(NSString *)URLString params:(NSDictionary *)params contentType:(NSString *)content completionBlock:(void(^)(id responseObject, NSError *error))completionBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [manager POST:URLString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject success: %@", responseObject);
        completionBlock(responseObject, nil);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"responseObject failure: %@", error);
        completionBlock(nil, error);
        
    }];
    
}


+ (NSData *)enCodeHttpRequestBody:(NSDictionary *)bodyDic
{
    NSMutableString *queryString = [[NSMutableString alloc] init];
    NSArray *allKeys = bodyDic.allKeys;
    for (NSString *key in allKeys) {
        NSString *value = [bodyDic objectForKey:key];
        if (![key isEqualToString:[allKeys lastObject]]) {
            if ([value isKindOfClass:[NSString class]]) {
                
                [queryString appendFormat:@"%@=%@&", key, [[value urlEncodeUsingEncoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"%26quot%3B" withString:@"%22"]];
            } else {
                [queryString appendFormat:@"%@=%@&", key, value];
            }
        } else {
            if ([value isKindOfClass:[NSString class]]) {
                [queryString appendFormat:@"%@=%@", key, [[value urlEncodeUsingEncoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"%26quot%3B" withString:@"%22"]];
            } else {
                [queryString appendFormat:@"%@=%@", key, value];
            }
        }
    }
    return [queryString dataUsingEncoding:NSUTF8StringEncoding];
}


@end
