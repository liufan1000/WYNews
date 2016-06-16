//
//  WYChannelView.h
//  网易新闻
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYChannel;

@interface WYChannelView : UIView

/**
 * 从 XIB 加载并返回视图
 */
+ (instancetype)channelView;

/**
 * 频道列表的数组
 */
@property (nonatomic, strong) NSArray <WYChannel *> *channelList;

@end
