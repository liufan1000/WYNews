//
//  WYChannelView.m
//  网易新闻
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "WYChannelView.h"
#import "WYChannel.h"
#import "WYChannelLabel.h"

@interface WYChannelView()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation WYChannelView

+ (instancetype)channelView {
    
    UINib *nib = [UINib nibWithNibName:@"WYChannelView" bundle:nil];
    
    return [nib instantiateWithOwner:nil options:nil].lastObject;
}

/**
 * 设置数据
 */
- (void)setChannelList:(NSArray<WYChannel *> *)channelList {
    _channelList = channelList;
    
    // 1. 初始数据准备
    CGFloat x = 30;
    CGFloat margin = 8;
    CGFloat height = _scrollView.bounds.size.height;
    
    // 向 scrollView 添加控件
    NSInteger idx = 0;
    for (WYChannel *channel in channelList) {
        
        // 1. 创建标签 - 已经计算好合适的 label 的宽度
        WYChannelLabel *l = [WYChannelLabel channelLabelWithTitle:channel.tname];
        
        // 2. 设置 label 的位置
        l.frame = CGRectMake(x, 0, l.bounds.size.width, height);
        
        // 3. 递增 x
        x += l.bounds.size.width + margin;
        
        // 4. 添加手势识别
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLabel:)];
        
        [l addGestureRecognizer:tap];
        
        // 设置 label 的 tag
        l.tag = idx++;
        
        // 5. 添加到滚动视图
        [_scrollView addSubview:l];
    }
    
    // 设置 scrollView 的 contentSize
    _scrollView.contentSize = CGSizeMake(x, height);
    
    // 取消滚动指示器
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    // 设置第 0 个标签的比例 1
    [self changeLableWithIndex:0 scale:1.0];
}

/**
 - touch: 方法实现在视图的内部，不便于外部的监听，如果用 touch 还需要通过代理或者自定义控件传递事件
 - 手势: 可以直接在外部添加视图的手势识别，便于监听！
 */
- (void)tapLabel:(UITapGestureRecognizer *)recognizer {
    // 获取 手势识别的 视图
    WYChannelLabel *l = (WYChannelLabel *)recognizer.view;
    
    NSLog(@"%@ %zd", l.text, l.tag);
    
    // 1> 记录属性值
    _selectedIndex = l.tag;
    
    // 2> 发送控件事件
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

/**
 * 修改指定 index label 的 scale 值
 *
 * @param index 标签的索引值
 * @param scale 缩放比例 0 ~ 1
 */
- (void)changeLableWithIndex:(NSInteger)index scale:(float)scale {
    
    // 1. 根据 index 取出对应的 label
    WYChannelLabel *l = _scrollView.subviews[index];
    
    // 2. 设置索引
    l.scale = scale;
}

@end
