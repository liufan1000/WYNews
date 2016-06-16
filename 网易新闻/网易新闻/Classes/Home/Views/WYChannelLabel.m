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

- (void)setScale:(float)scale {
    
    _scale = scale;
    
    // 最大缩放比例 18 -> 14 (1.0 -> 0.0)
    float max = (float)kSelectedSize / kNormalSize;
    // scale = 0
    float min = 1;
    
    // (18 / 14 - 1) * 1 + min
    // scale == 0 => s = 1
    float s = (max - 1) * scale + min;
    
    // 设置 label 的形变
    self.transform = CGAffineTransformMakeScale(s, s);
}

@end
