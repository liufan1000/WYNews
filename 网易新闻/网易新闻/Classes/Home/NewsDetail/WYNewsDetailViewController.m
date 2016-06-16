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
        
        // 追加图片测试数据
//        body = [body stringByAppendingString:@"<img src=\"http://dingyue.nosdn.127.net/ooo2sfnXhSUz8RYoWesGpNrhDkMaNzdbW1j8ynKDHuIlJ1466045195810.jpg\" />"];
        
        // 循环遍历 img 的数组
        // 查找 body 中 ref 的位置，如果找到使用 src 替换对应的图片内容
        for (NSDictionary *dict in img) {
            
            // 1> 获取 ref 的内容
            NSString *ref = dict[@"ref"];
            
            // 2> 在 body 中查找 ref 的位置
            NSRange range = [body rangeOfString:ref];
            
            // 3> 判断是否找到
            if (range.location == NSNotFound) {
                continue;
            }
            
            // 4> 替换 body range 对应的内容
            NSString *imgStr = [NSString stringWithFormat:@"<img src=\"%@\" />", dict[@"src"]];
            body = [body stringByReplacingCharactersInRange:range withString:imgStr];
        }
        
        // 4. 显示页面
        [self.webView loadHTMLString:body baseURL:nil];
    }];
}

@end
