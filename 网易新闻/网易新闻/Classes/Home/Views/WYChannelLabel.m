//
//  WYChannelLabel.m
//  网易新闻
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "WYChannelLabel.h"

#define kNormalSize 14
#define kSelectedSize 18

@implementation WYChannelLabel

+ (instancetype)channelLabelWithTitle:(NSString *)title {
    
    // 1. 实例化标签
    WYChannelLabel *l = [self cz_labelWithText:title fontSize:kSelectedSize color:[UIColor blackColor]];

    // 2. 设置文本对齐方式
    l.textAlignment = NSTextAlignmentCenter;
    
    // 3. 设置小字体
    l.font = [UIFont systemFontOfSize:kNormalSize];
    
    // 4. 返回标签，返回的 bounds 是 大字体的撑开的 bounds
    return l;
}

@end
