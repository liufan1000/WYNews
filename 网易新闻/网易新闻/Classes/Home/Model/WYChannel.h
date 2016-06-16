//
//  WYChannel.h
//  网易新闻
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYChannel : NSObject

/**
 * 频道名称
 */
@property (nonatomic, copy) NSString *tname;
/**
 * 频道 ID
 */
@property (nonatomic, copy) NSString *tid;

/**
 * 返回频道模型数组
 */
+ (NSArray *)channelList;

@end
