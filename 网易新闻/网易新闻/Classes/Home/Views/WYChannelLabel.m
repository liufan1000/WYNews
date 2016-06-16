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
    
    // 4. 开启用户交互
    l.userInteractionEnabled = YES;
    
    // 5. 返回标签，返回的 bounds 是 大字体的撑开的 bounds
    return l;
}

/**
 * 在视图内部实现，无法在外部监听
 */
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"%s %@", __FUNCTION__, self.text);
//}

// 提示：这种缩放比例的公式是固定的，可以记在笔记本中，如果开发时碰到，直接抄！
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
    
    // 颜色!!! 的技巧很重要
    // scale == 1 红色，scale == 0 黑色
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1.0];
}

@end
