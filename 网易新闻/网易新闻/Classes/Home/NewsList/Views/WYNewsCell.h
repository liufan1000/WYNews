//
//  WYNewsCell.h
//  网易新闻
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYNewsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyLabel;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *extraIcon;

@end
