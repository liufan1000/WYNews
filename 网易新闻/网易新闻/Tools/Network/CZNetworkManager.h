//
//  CZNetworkManager.h
//  网易新闻
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface CZNetworkManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

/**
 * 加载网易新闻列表
 *
 * @param channel    频道字符串
 * @param start      开始数字
 * @param completion 完成回调[字典数组／错误]
 */
- (void)newsListWithChannel:(NSString *)channel start:(NSInteger)start completion:(void (^)(NSArray *array, NSError *error))completion;

@end
