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

@interface WYHomeViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
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
    
    // 0. 加载频道数据
    _channelList = [WYChannel channelList];
    
    // 1. 设置 UI
    [self setupUI];
    
    // 2. 设置数据
    _channelView.channelList = _channelList;
}

#pragma mark - UIPageViewControllerDelegate
/**
 问题：不能监听滚动的过程动作！只能监听到开始和结束
 
 * [pageViewController.view subviews[0]] 是一个滚动视图
 * KVO 专门用来监听对象的属性变化！
 */
// 将要展现下一个控制器
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<WYNewsListViewController *> *)pendingViewControllers {
    
    // 当前的控制器数组
    NSLog(@"当前的控制器 %@", [pageViewController.viewControllers valueForKey:@"channelIndex"]);
    
    // 要显示的控制器数组
    NSLog(@"要显示的控制器 %@", [pendingViewControllers valueForKey:@"channelIndex"]);
    
    // 输出滚动视图
    NSLog(@"%@", [pageViewController.view subviews][0]);
}

// 完成展现控制器动画
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<WYNewsListViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    // 前一个控制器数组
    NSLog(@"%@", [previousViewControllers valueForKey:@"channelIndex"]);
}

#pragma mark - UIPageViewControllerDataSource
// 返回前一个控制器
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(WYNewsListViewController *)viewController {
    
    // 1. 取当前控制器的频道索引
    NSInteger idx = viewController.channelIndex;
    
    // 2. 递减 idx
    idx--;
    
    // 3. 判断 idx
    if (idx < 0) {
        NSLog(@"没有前一个");
        return nil;
    }
    
    // 4. 创建新的控制器并且返回
    WYNewsListViewController *vc = [[WYNewsListViewController alloc] initWithChannelId:_channelList[idx].tid index:idx];
    
    return vc;
}

// 返回后一个控制器
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(WYNewsListViewController *)viewController {
    
    // 1. 取当前控制器的频道索引
    NSInteger idx = viewController.channelIndex;
    
    // 2. 递增 idx
    idx++;
    
    // 3. 判断 idx
    if (idx >= _channelList.count) {
        NSLog(@"没有后一个");
        return nil;
    }
    
    // 4. 创建新的控制器并且返回
    WYNewsListViewController *vc = [[WYNewsListViewController alloc] initWithChannelId:_channelList[idx].tid index:idx];
    
    return vc;
}

#pragma mark - 设置界面
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor cz_randomColor];
    
    // 0. 取消自动调整滚动视图间距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
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
    WYNewsListViewController *vc = [[WYNewsListViewController alloc] initWithChannelId:_channelList[0].tid index:0];
    
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
    
    // 6. 设置数据源和代理
    pc.dataSource = self;
    pc.delegate = self;
}

@end
