//
//  AppDelegate.m
//  网易新闻
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setupAppearance];
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    
    Class cls = NSClassFromString(@"WYMainViewController");
    UIViewController *vc = [cls new];
    
    _window.rootViewController = vc;
    [_window makeKeyAndVisible];
    
    return YES;
}

/**
 * 设置外观 appearance 是一个协议，设置控件全局外观
 */
- (void)setupAppearance {
    
    // 设置 tabBar 的渲染颜色 - 会设置`后续[外观设置之后的]` UITabBar 的 tintColor 全部是指定的颜色
    [UITabBar appearance].tintColor = [UIColor cz_colorWithHex:0xDF0000];
}

@end
