//
//  TNBaseNavigationController.m
//  BaseProject
//
//  Created by Tony on 2017/8/4.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "TNBaseNavigationController.h"


#define TintColor [UIColor whiteColor]

@interface TNBaseNavigationController ()<UINavigationControllerDelegate>
@property (nonatomic, weak) id<UINavigationControllerDelegate> myDelegate;//代理对象


@end

@implementation TNBaseNavigationController


- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super initWithRootViewController:rootViewController]) {
        [super setDelegate:self];
        
        //统一处理
        rootViewController.view.backgroundColor = tnBackgroundColor;
    
    }
    return self;
}

- (void)clickedLeftBarButtonItem{
    
}

- (void)clickedRightBarButtonItem{
    
}

- (void)setDelegate:(id<UINavigationControllerDelegate>)delegate{
    
    if (delegate == self) return;
    
    _myDelegate = delegate;
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBackgroundImage:[UIImage tn_creatImageWithColor:tnMainColor] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setTintColor:TintColor];
    self.navigationBar.titleTextAttributes = @{NSFontAttributeName:tnBoldFont(17), NSForegroundColorAttributeName:TintColor};
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    UIViewController *root = self.viewControllers[0];
    
    if (root != viewController) {
        UIBarButtonItem *itemleft = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_button_back"] style:UIBarButtonItemStylePlain target:self action:@selector(popAction:)];
        viewController.navigationItem.leftBarButtonItem = itemleft;
        //在切换界面的过程中禁止滑动手势，避免界面卡死
        if ([viewController.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            viewController.navigationController.interactivePopGestureRecognizer.enabled = NO;
            viewController.navigationController.interactivePopGestureRecognizer.delegate = nil;
        }
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //开启滑动手势
    
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    //代理传出
    if ([_myDelegate respondsToSelector:@selector(navigationController:willShowViewController:animated:)]) {
        [_myDelegate navigationController:navigationController willShowViewController:viewController animated:animated];
    }
    
}


- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([super respondsToSelector:aSelector]) return YES;
    //没有实现的代理方法
    return [_myDelegate respondsToSelector:aSelector];
}

//将这个SEL转给其他对象
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    NSLog(@"_cmd: %@", NSStringFromSelector(_cmd));
    if ([_myDelegate respondsToSelector:aSelector]) return _myDelegate;
    return [super forwardingTargetForSelector:aSelector];
}



- (void)popAction:(UIBarButtonItem *)barButtonItem
{
    [self popViewControllerAnimated:YES];
}





@end
