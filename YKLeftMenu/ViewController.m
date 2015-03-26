//
//  ViewController.m
//  YKLeftMenu
//
//  Created by Mark on 15/3/25.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "ViewController.h"
#import "YKLeftMenu.h"
#define leftMenuW  220
#define leftMenuH  320
#define leftMenuY  100
#define kAnimateDuration 0.5
@interface ViewController () <YKLeftMenuDelegate>{
    UIImageView *_BGImageView;
    NSInteger _currentIndex;
    UIBarButtonItem *_left;
    UIView *_leftMenu;
    UIButton *_cover;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _currentIndex = 0;
    // 背景图片
    _BGImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _BGImageView.image = [UIImage imageNamed:@"sidebar_bg@2x.jpg"];
    [self.view addSubview:_BGImageView];
    // 左边menu
    YKLeftMenu *leftMenu = [[YKLeftMenu alloc] initWithFrame:CGRectMake(-leftMenuW, leftMenuY, leftMenuW, leftMenuH)];
    [self.view addSubview:leftMenu];
    _leftMenu = leftMenu;
    
    leftMenu.delegate = self;
    // 在这可以设置每个子视图的控制器
    [self addNavAsChildWithTitle:@"新闻"];
    [self addNavAsChildWithTitle:@"订阅"];
    [self addNavAsChildWithTitle:@"图片"];
    [self addNavAsChildWithTitle:@"视频"];
    [self addNavAsChildWithTitle:@"跟帖"];
    [self addNavAsChildWithTitle:@"电台"];
    UINavigationController *nav = self.childViewControllers[0];
    [self.view addSubview:nav.view];
}
#pragma mark - Private Methods
/**
 *  创建一个navigationController，并添加到为子控制器
 *
 *  @param title 控制器的root controller的标题
 */
- (void)addNavAsChildWithTitle:(NSString *)title{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0];
    // UINavigationController属于容器，最少需要一个RootController，Title是设置在容器中的Controller上
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.barTintColor = [UIColor colorWithRed:168.0/255.0 green:20.0/255.0 blue:4.0/255.0 alpha:1.0];
    // title color
    NSDictionary *attris = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0]};
    nav.navigationBar.titleTextAttributes = attris;
    nav.navigationBar.tintColor = [UIColor whiteColor];
    // left barItem
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_navigation_menuicon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftPressed)];
    vc.navigationItem.leftBarButtonItem = left;
    vc.title = title;
    // add gesture
    [self addSwipToView:vc.view withDirection:UISwipeGestureRecognizerDirectionRight];
    
    [self addChildViewController:nav];
}
- (void)swipTheView:(UISwipeGestureRecognizer *)recognizer{
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        CGFloat width = self.view.frame.size.width;
        CGFloat height = self.view.frame.size.height;
        UINavigationController *nav = self.childViewControllers[_currentIndex];
        [UIView animateWithDuration:kAnimateDuration animations:^{
            // animation of View controller
            UIView *view = nav.view;
            // add cover
            [self addCoverToView:view];
            CGFloat scale = leftMenuH / height;
            CGAffineTransform scaleTransf = CGAffineTransformMakeScale(scale, scale);
            CGFloat targetX = leftMenuW - width * (1 - scale) / 2;
            CGFloat targetY = leftMenuY - height * (1 - scale) / 2;
            CGAffineTransform transf = CGAffineTransformTranslate(scaleTransf, targetX / scale, targetY / scale);
            view.transform = transf;
            // animation of left menu
            _leftMenu.transform = CGAffineTransformMakeTranslation(leftMenuW, 0);
        }];
    }
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        [_cover removeFromSuperview];
        UINavigationController *nav = self.childViewControllers[_currentIndex];
        [UIView animateWithDuration:kAnimateDuration animations:^{
            // clear transform
            nav.view.transform = CGAffineTransformIdentity;
            _leftMenu.transform = CGAffineTransformIdentity;
        }];
    }
}
/**
 *  给视图添加一个按钮挡板
 *
 *  @param view 视图
 */
- (void)addCoverToView:(UIView *)view{
    UIButton *cover = [[UIButton alloc] initWithFrame:view.bounds];
    [cover addTarget:self action:@selector(coverPressed:) forControlEvents:UIControlEventTouchUpInside];
    // add gesture
    [self addSwipToView:cover withDirection:UISwipeGestureRecognizerDirectionLeft];
    
    [view addSubview:cover];
    _cover = cover;
}
/**
 *  为视图添加滑动手势
 *
 *  @param view      视图
 *  @param direction 滑动方向
 */
- (void)addSwipToView:(UIView *)view withDirection:(UISwipeGestureRecognizerDirection)direction {
    UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipTheView:)];
    swip.direction = direction;
    [view addGestureRecognizer:swip];
}
- (void)leftPressed{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    UINavigationController *nav = self.childViewControllers[_currentIndex];
    [UIView animateWithDuration:kAnimateDuration animations:^{
        // animation of View controller
        UIView *view = nav.view;
        // add cover
        [self addCoverToView:view];
        CGFloat scale = leftMenuH / height;
        CGAffineTransform scaleTransf = CGAffineTransformMakeScale(scale, scale);
        CGFloat targetX = leftMenuW - width * (1 - scale) / 2;
        CGFloat targetY = leftMenuY - height * (1 - scale) / 2;
        CGAffineTransform transf = CGAffineTransformTranslate(scaleTransf, targetX / scale, targetY / scale);
        view.transform = transf;
        // animation of left menu
        _leftMenu.transform = CGAffineTransformMakeTranslation(leftMenuW, 0);
    }];
}
- (void)coverPressed:(UIButton *)button{
    [button removeFromSuperview];
    UINavigationController *nav = self.childViewControllers[_currentIndex];
    [UIView animateWithDuration:kAnimateDuration animations:^{
        // clear transform
        nav.view.transform = CGAffineTransformIdentity;
        _leftMenu.transform = CGAffineTransformIdentity;
    }];
}
/**
 *  设置状态栏风格
 *
 *  @return 白色风格
 */
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
#pragma mark - YKLeftMenuDelegate
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
@end
