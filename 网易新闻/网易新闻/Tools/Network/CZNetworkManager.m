//
//  CZNetworkManager.m
//  网易新闻
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CZNetworkManager.h"

@implementation CZNetworkManager

+ (instancetype)sharedManager {
    static CZNetworkManager *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 末尾要有反斜线
        NSURL *baseURL = [NSURL URLWithString:@"http://c.m.163.com/nc/article/"];
        
        instance = [[self alloc] initWithBaseURL:baseURL];
        
        // 设置相应的解析格式
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    
    return instance;
}

#pragma mark - 封装 AFN 网络请求
/**
 * 发起 GET 请求 － 之所以封装 GET 方法，为了保证替换网络框架使用！
 *
 * @param URLString  URLString
 * @param parameters 参数字典
 * @param completion 完成回调[json(字典／数组)，错误]
 */
- (void)GETRequest:(NSString *)URLString parameters:(NSDictionary *)parameters completion:(void (^)(id json, NSError *error))completion {
    
    [self GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"网络请求失败 %@", error);
        
        completion(nil, error);
    }];
}

#pragma mark - 网易新闻接口
- (void)newsListWithChannel:(NSString *)channel start:(NSInteger)start completion:(void (^)(NSArray *, NSError *))completion {
    
    NSString *urlString = [NSString stringWithFormat:@"list/%@/%zd-20.html", channel, start];
    
    [self GETRequest:urlString parameters:nil completion:^(id json, NSError *error) {

        // 使用频道作为 key 获取数组
        NSArray *array = json[channel];
        
        completion(array, error);
    }];
}

- (void)newsDetailWithDocId:(NSString *)docId completion:(void (^)(NSDictionary *, NSError *))completion {
    
    NSString *urlString = [NSString stringWithFormat:@"%@/full.html", docId];
    
    [self GETRequest:urlString parameters:nil completion:^(id json, NSError *error) {
       
        // NSLog(@"%@", json);
        // 完成回调
        completion(json[docId], error);
    }];
}

@end
