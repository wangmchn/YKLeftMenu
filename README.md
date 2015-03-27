# YKLeftMenu
## Description
一直不知道侧边导航栏的实现，看了教程之后，自己也动手实现了一下。  
也对tabBarController实现方式有了一些理解(如果两个控制器互为父子关系，那么他们的view也应该互为父子关系)。<br>
特别感谢MJ老师的教程
### LeftMenu
	提供一个代理方法
```Objective-C
/**
 *  代理方法，侧边菜单栏点击是触发
 *
 *  @param leftMenu  leftMenuView
 *  @param fromIndex 原始序号
 *  @param index     目标序号
 */
- (void)leftMenu:(YKLeftMenu *)leftMenu ChangeViewControllerFrom:(NSInteger)fromIndex to:(NSInteger)index;
```
### A useful method
```Objective-C
// 用于生成对应color的位图
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
```
## Problem Remains
```Objective-C
- (void)leftMenu:(YKLeftMenu *)leftMenu ChangeViewControllerFrom:(NSInteger)fromIndex to:(NSInteger)index{
    UINavigationController *oldNav = self.childViewControllers[_currentIndex];
    CGAffineTransform transf = oldNav.view.transform;
    [oldNav.view removeFromSuperview];
    _currentIndex = index;
    UINavigationController *newNav = self.childViewControllers[_currentIndex];
    newNav.view.transform = transf;
    [self.view addSubview:newNav.view];
    // 奇怪的现象，若我注释掉下面的动画，在屏幕上显示的NavigationBar会变矮，缩短的高度大概就是状态栏的高度
    // 找不到原因，若知道，还请告知，万分感谢！
    [UIView animateWithDuration:kAnimateDuration animations:^{
        newNav.view.transform = CGAffineTransformIdentity;
        _leftMenu.transform = CGAffineTransformIdentity;
    }];
    [_cover removeFromSuperview];
}
```
