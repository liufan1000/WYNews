//
//  WYChannelLabel.h
//  网易新闻
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 频道标签
 */
@interface WYChannelLabel : UILabel

/**
 * 使用标题实例化标签
 */
+ (instancetype)channelLabelWithTitle:(NSString *)title;

/**
 * 假定 scale 的值 0 ~ 1
 *
 * == 0，字体大小 14 号，黑色
 * == 1，字体大小 18 号，红色
 */
@property (nonatomic, assign) float scale;

@end
