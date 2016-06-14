//
//  WYMainViewController.m
//  网易新闻
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "WYMainViewController.h"

@interface WYMainViewController ()

@end

@implementation WYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewControllers];
}

#pragma mark - 添加子控制器
/**
 * 添加所有的子控制器
 */
- (void)addChildViewControllers {
    
    // 设置 tabBar 的字体颜色
    self.tabBar.tintColor = [UIColor cz_colorWithHex:0xDF0000];
    
    // 视图控制器的字典数组
    NSArray *array = @[
                       @{@"clsName": @"UIViewController", @"title": @"新闻", @"imageName": @"news"},
                       @{@"clsName": @"UIViewController", @"title": @"阅读", @"imageName": @"reader"},
                       @{@"clsName": @"UIViewController", @"title": @"视频", @"imageName": @"media"},
                       @{@"clsName": @"UIViewController", @"title": @"话题", @"imageName": @"bar"},
                       @{@"clsName": @"UIViewController", @"title": @"我", @"imageName": @"me"},
                       ];
    
    // 遍历数组，创建控制器数组
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        
        [arrayM addObject:[self childControllerWithDict:dict]];
    }
    
    // 设置子控制器数组
    self.viewControllers = arrayM.copy;
}

/**
 * 创建一个子控制器
 */
- (UIViewController *)childControllerWithDict:(NSDictionary *)dict {
    
    // 1. 创建控制器
    NSString *clsName = dict[@"clsName"];
    Class cls = NSClassFromString(clsName);
    
    NSAssert(cls != nil, @"传入了类名错误");
    UIViewController *vc = [cls new];
    
    // 2. 设置标题
    vc.title = dict[@"title"];
    
    // 3. 图片
    NSString *imageName = [NSString stringWithFormat:@"tabbar_icon_%@_normal", dict[@"imageName"]];
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    // 高亮图片
    NSString *imageNameHL = [NSString stringWithFormat:@"tabbar_icon_%@_highlight", dict[@"imageName"]];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:imageNameHL] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 4. 添加导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    // 5. 返回导航控制器
    return nav;
}

@end
