//
//  WYHomeViewController.m
//  网易新闻
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "WYHomeViewController.h"
#import "WYChannelView.h"
#import "WYChannel.h"

@interface WYHomeViewController ()
/**
 * 频道视图
 */
@property (nonatomic, weak) WYChannelView *channelView;
@end

@implementation WYHomeViewController {
    NSArray <WYChannel *> *_channelList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 设置 UI
    [self setupUI];
    
    // 加载频道数据
    _channelList = [WYChannel channelList];
    
    // 2. 设置数据
    _channelView.channelList = _channelList;
}

#pragma mark - 设置界面
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor cz_randomColor];
    
    // 1. 添加频道视图
    WYChannelView *cv = [WYChannelView channelView];
    
    [self.view addSubview:cv];
    
    [cv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(38);
    }];
    
    // 记录成员变量
    _channelView = cv;
}

@end
