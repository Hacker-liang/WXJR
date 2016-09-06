//
//  WXNetworkingAPI.m
//  WXJR
//
//  Created by liangpengshuai on 8/31/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

#import "WXNetworkingAPI.h"

@implementation WXNetworkingAPI

+ (void)GET:(NSString *)URLString params:(NSDictionary *)params completionBlock:(void(^)(BOOL isSuccess, id responseObject, NSError *error))completionBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:URLString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

+ (void)POST:(NSString *)URLString params:(NSDictionary *)params completionBlock:(void(^)(BOOL isSuccess, id responseObject, NSError *error))completionBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:URLString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject: %@", responseObject);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"responseObject: %@", error);

    }];
    
}

@end
