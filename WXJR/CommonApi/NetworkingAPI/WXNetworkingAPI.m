//
//  WXNetworkingAPI.m
//  WXJR
//
//  Created by liangpengshuai on 8/31/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

#import "WXNetworkingAPI.h"
#import "WXJR-swift.h"

@implementation WXNetworkingAPI

+ (void)GET:(NSString *)URLString params:(NSDictionary *)params completionBlock:(void(^)(id responseObject, NSError *error))completionBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    if ([[WXAccountManager shareInstance] userIsLoginIn]) {
        NSLog(@"access_token: %@", [WXAccountManager shareInstance].accountDetail.access_token);
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", [WXAccountManager shareInstance].accountDetail.access_token] forHTTPHeaderField:@"Authorization"];
    }
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
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

@end
