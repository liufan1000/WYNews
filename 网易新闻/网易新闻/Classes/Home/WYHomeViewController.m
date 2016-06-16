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
#import "WYNewsListViewController.h"

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
    
    // 2. 设置分页控制器
    [self setupPageController];
}

/**
 * 添加分页控制器
 */
- (void)setupPageController {
    
    // 1. 实例化控制器
    UIPageViewController *pc = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    // 2. 设置分页控制器的`子控制器（新闻列表控制器）`
    WYNewsListViewController *vc = [WYNewsListViewController new];
    
    [pc setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // 3. 将分页控制器当作子控制器添加到当前控制器
    [self addChildViewController:pc];
    
    // 4. 添加视图，并且完成自动布局
    [self.view addSubview:pc.view];
    
    [pc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.channelView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    // 5. 完成子控制器的添加
    [pc didMoveToParentViewController:self];
}

@end
