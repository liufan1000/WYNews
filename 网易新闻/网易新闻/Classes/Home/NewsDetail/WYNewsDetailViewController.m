//
//  WYNewsDetailViewController.m
//  网易新闻
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "WYNewsDetailViewController.h"
#import "WYNewsListItem.h"

@interface WYNewsDetailViewController ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation WYNewsDetailViewController

- (void)loadView {
    _webView = [UIWebView new];
    
    self.view = _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"接收到的模型 %@", _item);
}

@end
