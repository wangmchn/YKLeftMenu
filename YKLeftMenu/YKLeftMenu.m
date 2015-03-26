//
//  YKLeftMenu.m
//  YKLeftMenu
//
//  Created by Mark on 15/3/25.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "YKLeftMenu.h"
#import "UIImage+Color.h"
#define kAlapha 0.2

@interface YKLeftMenu()
{
    UIButton *selectedButton;
}
@end
@implementation YKLeftMenu

#pragma mark - init
- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        UIColor *color = [[UIColor alloc] initWithRed:187.0/255.0 green:67.0/255.0 blue:71.0/255.0 alpha:kAlapha];
        [self addButtonWithIconName:@"sidebar_nav_news.png" title:@"新闻" tintColor:color];
        
        color = [[UIColor alloc] initWithRed:187.0/255.0 green:114.0/255.0 blue:72.0/255.0 alpha:kAlapha];
        [self addButtonWithIconName:@"sidebar_nav_reading.png" title:@"订阅" tintColor:color];
        
        color = [[UIColor alloc] initWithRed:67.0/255.0 green:125.0/255.0 blue:187.0/255.0 alpha:kAlapha];
        [self addButtonWithIconName:@"sidebar_nav_photo.png" title:@"图片" tintColor:color];
        
        color = [[UIColor alloc] initWithRed:113.0/255.0 green:176.0/255.0 blue:97.0/255.0 alpha:kAlapha];
        [self addButtonWithIconName:@"sidebar_nav_video.png" title:@"视频" tintColor:color];
        
        color = [[UIColor alloc] initWithRed:163.0/255.0 green:165.0/255.0 blue:59.0/255.0 alpha:kAlapha];
        [self addButtonWithIconName:@"sidebar_nav_comment.png" title:@"跟帖" tintColor:color];
        
        color = [[UIColor alloc] initWithRed:184.0/255.0 green:60.0/255.0 blue:116.0/255.0 alpha:kAlapha];
        [self addButtonWithIconName:@"sidebar_nav_radio.png" title:@"电台" tintColor:color];
    }
    return self;
}
- (void)setDelegate:(id<YKLeftMenuDelegate>)delegate{
    // set切记不可 self.delegate 因为其本质是调用set方法
    _delegate = delegate;
    selectedButton = self.subviews[0];
    selectedButton.selected = YES;
}
#pragma mark - Private Methods
- (void)addButtonWithIconName:(NSString *)icon title:(NSString *)title tintColor:(UIColor *)color{
    UIButton *button = [[UIButton alloc] init];
    [self addSubview:button];
    // 设置button的title、icon
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    // 选中的背景图
    [button setBackgroundImage:[UIImage imageWithColor:color] forState:UIControlStateSelected];
    // 选中时，icon不变灰
    button.adjustsImageWhenHighlighted = NO;
    // 点击事件
    [button addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    // 按钮内部向左对齐
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    // 标题
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    button.contentEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
}
- (void)btnPressed:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(leftMenu:ChangeViewControllerFrom:to:)]) {
        [self.delegate leftMenu:self ChangeViewControllerFrom:selectedButton.tag to:button.tag];
    }
    selectedButton.selected = NO;
    button.selected = YES;
    selectedButton = button;
}
#pragma mark - layout
- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSArray *buttons = self.subviews;
    NSInteger count = buttons.count;
    CGFloat btnW = self.bounds.size.width;
    CGFloat btnH = self.bounds.size.height / count;
    for (int i = 0; i < count; i++) {
        UIButton *button = buttons[i];
        CGRect frame = CGRectMake(0, btnH * i, btnW, btnH);
        button.tag = i;
        button.frame = frame;
    }
}
@end
