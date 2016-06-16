//
//  WYNewsListViewController.h
//  网易新闻
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 新闻列表控制器，显示每一个频道的新闻列表
 */
@interface WYNewsListViewController : UIViewController

/**
 * 使用频道代号和索引创建控制器
 *
 * @param channelId 频道代号
 * @param index     频道索引
 *
 * @return 控制器
 */
- (instancetype)initWithChannelId:(NSString *)channelId index:(NSInteger)index;

/**
 * 频道代号
 */
@property (nonatomic, strong, readonly) NSString *channelId;
/**
 * 频道的索引，在数组中的下标 - 在使用 pageViewController 的时候，索引必须记录在子控制器中
 */
@property (nonatomic, assign, readonly) NSInteger channelIndex;

@end
