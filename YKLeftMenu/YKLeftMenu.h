//
//  YKLeftMenu.h
//  YKLeftMenu
//
//  Created by Mark on 15/3/25.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YKLeftMenu;
@protocol YKLeftMenuDelegate <NSObject>
/**
 *  代理方法
 *
 *  @param leftMenu  leftMenuView
 *  @param fromIndex 原始序号
 *  @param index     目标序号
 */
- (void)leftMenu:(YKLeftMenu *)leftMenu ChangeViewControllerFrom:(NSInteger)fromIndex to:(NSInteger)index;

@end

@interface YKLeftMenu : UIView
@property (nonatomic, weak) id<YKLeftMenuDelegate> delegate;
@end
