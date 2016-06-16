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

/**
 * 修改指定 index label 的 scale 值
 *
 * @param index 标签的索引值
 * @param scale 缩放比例 0 ~ 1
 */
- (void)changeLableWithIndex:(NSInteger)index scale:(float)scale;

@end
