//
//  WYChannelView.m
//  网易新闻
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "WYChannelView.h"
#import "WYChannel.h"

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
    
    // 向 scrollView 添加控件
    for (WYChannel *channel in channelList) {
        // 1. 创建标签
        UILabel *l = [UILabel cz_labelWithText:channel.tname fontSize:14 color:[UIColor blackColor]];
        
        // 2. 添加到滚动视图
        [_scrollView addSubview:l];
    }
}

@end
