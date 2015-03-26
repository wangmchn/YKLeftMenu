//
//  UIImage+Color.m
//  YKLeftMenu
//
//  Created by Mark on 15/3/25.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)
+ (UIImage *)imageWithColor:(UIColor *)color{
    // 1. 开启基于位图的图形上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100, 100), YES, 0.0);
    // 2. 画一个矩形框并填充
    [color set];
    UIRectFill(CGRectMake(0, 0, 100, 100));
    // 3. 获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 4. 关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}
@end
