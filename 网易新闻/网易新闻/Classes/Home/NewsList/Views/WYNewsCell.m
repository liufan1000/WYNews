//
//  WYNewsCell.m
//  网易新闻
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "WYNewsCell.h"
#import "WYNewsListItem.h"

@interface WYNewsCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyLabel;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *extraIcon;

@end

@implementation WYNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setNewsItem:(WYNewsListItem *)newsItem {
    _newsItem = newsItem;
    
    // 设置数据
    _titleLabel.text = newsItem.title;
    _sourceLabel.text = newsItem.source;
    _replyLabel.text = @(newsItem.replyCount).description;
    
    // 设置图片
    [_iconView cz_setImageWithURLString:newsItem.imgsrc];
    
    // 设置多图 － 如果没有不会进入循环
    NSInteger idx = 0;
    for (NSDictionary *dict in newsItem.imgextra) {
        
        // 设置图像
        [_extraIcon[idx++] cz_setImageWithURLString:dict[@"imgsrc"]];
    }
}

@end
