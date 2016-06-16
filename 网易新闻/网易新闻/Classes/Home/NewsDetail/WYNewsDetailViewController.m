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
    
    // NSLog(@"接收到的模型 %@", _item);
    [self loadData];
}

- (void)loadData {
    
    [[CZNetworkManager sharedManager] newsDetailWithDocId:_item.docid completion:^(NSDictionary *dict, NSError *error) {
       
        // NSLog(@"%@", dict);
        // 1. body
        NSString *body = dict[@"body"];
        // 2. img
        NSArray *img = dict[@"img"];
        // 3. video
        NSArray *video = dict[@"video"];
        
        NSLog(@"%@", body);
        NSLog(@"%@", img);
        NSLog(@"%@", video);
        
        // 4. 显示页面
        [self.webView loadHTMLString:body baseURL:nil];
    }];
}

@end
