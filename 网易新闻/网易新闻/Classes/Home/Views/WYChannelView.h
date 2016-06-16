//
//  WYChannelView.h
//  网易新闻
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYChannel;

/**
 自定义控件
 
 1. 继承自 UIControl
 2. 监听方通过属性，访问触发事件内部的属性 - 定义一个属性
 3. 在发生事件时，记录属性值，发送事件消息
 */
@interface WYChannelView : UIControl

/**
 * 从 XIB 加载并返回视图
 */
+ (instancetype)channelView;

/**
 * 频道列表的数组
 */
@property (nonatomic, strong) NSArray <WYChannel *> *channelList;
/**
 * 选中的标签索引
 */
@property (nonatomic, assign, readonly) NSInteger selectedIndex;

/**
 * 修改指定 index label 的 scale 值
 *
 * @param index 标签的索引值
 * @param scale 缩放比例 0 ~ 1
 */
- (void)changeLableWithIndex:(NSInteger)index scale:(float)scale;

@end
