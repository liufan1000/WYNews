//
//  UIImageView+CZ_WebImage.h
//  网易新闻
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (CZ_WebImage)

/**
 * 使用 URLString 设置网络图片
 */
- (void)cz_setImageWithURLString:(NSString *)urlString;

@end
