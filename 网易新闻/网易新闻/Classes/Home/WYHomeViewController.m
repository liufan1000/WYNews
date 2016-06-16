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

@end

@implementation WYHomeViewController {
    NSArray <WYChannel *> *_channelList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    // 测试频道数据
    _channelList = [WYChannel channelList];
    
    NSLog(@"%@", _channelList);
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
}

@end
