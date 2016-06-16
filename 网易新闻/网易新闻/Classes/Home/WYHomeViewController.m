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

/**
 * 分页控制器
 */
@property (nonatomic, weak) UIPageViewController *pageViewController;

/**
 * 分页控制器内部的滚动视图
 */
@property (nonatomic, weak) UIScrollView *pageScrollView;

/**
 * 当前显示的列表控制器
 */
@property (nonatomic, weak) WYNewsListViewController *currentListVC;
/**
 * 将要显示的列表控制器
 */
@property (nonatomic, weak) WYNewsListViewController *nextListVC;
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

#pragma mark - KVO 的监听方法
/**
 * 是 KVO 统一调用的监听方法
 *
 * @param keyPath 监听的 keyPath(属性)
 * @param object  监听的对象，可以通过对象获得属性值
 * @param change  监听的变化
 * @param context 上下文，一般是 NULL
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    // NSLog(@"%@ %@ %@", keyPath, object, change);
    // contentOffset.x 375 -> 0 / 375 -> 750
    // 通过变化，计算出比例 0 ~ 1
    // NSLog(@"===> %@", NSStringFromCGPoint(_pageScrollView.contentOffset));
    
    CGFloat width = _pageScrollView.bounds.size.width;
    CGFloat offsetX = ABS(_pageScrollView.contentOffset.x - width);
    
    CGFloat scale = offsetX / width;
    
    NSLog(@"%f 从 %zd 到 %zd", scale, _currentListVC.channelIndex, _nextListVC.channelIndex);
    // scale 0 -> 1
    // 头条 1 -> 0
    // 社会 0 -> 1
    
    // 根据索引调整频道视图中的标签的比例
    [_channelView changeLableWithIndex:_currentListVC.channelIndex scale:(1 - scale)];
    [_channelView changeLableWithIndex:_nextListVC.channelIndex scale:scale];
}

#pragma mark - UIPageViewControllerDelegate
/**
 问题：不能监听滚动的过程动作！只能监听到开始和结束
 
 * [pageViewController.view subviews[0]] 是一个滚动视图
 * KVO 专门用来监听对象的属性变化！
 * KVO 是观察者模式，除了 KVO 还有通知，在不需要使用时，应该注销观察者
 */
// 将要展现下一个控制器
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<WYNewsListViewController *> *)pendingViewControllers {
    
    // 当前的控制器数组
    NSLog(@"当前的控制器 %@", [pageViewController.viewControllers valueForKey:@"channelIndex"]);
    
    // 要显示的控制器数组
    NSLog(@"要显示的控制器 %@", [pendingViewControllers valueForKey:@"channelIndex"]);
    
    // 记录当前控制器和将要显示的控制器
    _currentListVC = pageViewController.viewControllers[0];
    _nextListVC = pendingViewControllers[0];
    
    // 输出滚动视图
    // NSLog(@"%@", [pageViewController.view subviews][0]);
    NSLog(@"%@", _pageScrollView);
    
    // KVO 监听滚动视图
    [_pageScrollView addObserver:self forKeyPath:@"contentOffset" options:0 context:NULL];
}

// 完成展现控制器动画
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<WYNewsListViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    // 前一个控制器数组
    NSLog(@"滚动结束 %@", [previousViewControllers valueForKey:@"channelIndex"]);
    
    // 注销滚动视图的观察 - 一旦注销观察者，后续分页控制器的复位导致的 contentOffset 不再监听！
    // 保证监听的数值变化就是一个完整屏幕的变化！
    [_pageScrollView removeObserver:self forKeyPath:@"contentOffset"];
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
    
    // 7. 记录成员变量
    _pageViewController = pc;
    
    if ([pc.view.subviews[0] isKindOfClass:[UIScrollView class]]) {
        _pageScrollView = pc.view.subviews[0];
    }
}

@end
