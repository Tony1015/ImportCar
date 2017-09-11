//
//  TNPromptBox.m
//  BaseProject
//
//  Created by Tony on 2017/8/7.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "TNPromptBox.h"


#define tnPromptBoxCornerRadius 10.0
#define tnPromptWordFont [UIFont systemFontOfSize:15]
#define tnPromptWordMargin   10.0
#define tnPromptBoxBackGroundColor [UIColor lightGrayColor]


#ifndef tnAppWindow
#define tnAppWindow [[UIApplication sharedApplication].delegate window]
#endif

@implementation TNPromptBox

+ (void)showPromptBoxWithWords:(NSString *)words
{
    [self showPromptBoxWithWords:words toView:nil];
}
+ (void)showPromptBoxWithWords:(NSString *)words toView:(UIView *)view
{
    [self showPromptBoxWithWords:words icon:nil toView:view];
}
+ (void)showPromptBoxWithWords:(NSString *)words icon:(UIImage *)icon
{
    [self showPromptBoxWithWords:words icon:icon toView:nil];
}
+ (void)showPromptBoxWithWords:(NSString *)words icon:(UIImage *)icon toView:(UIView *)view
{
    if (!words.length) return;
    if (![[NSThread currentThread] isMainThread]) {
        return;
    }
    
    if (view == nil) view = tnAppWindow;
    
    //把该视图上还在显示的取消
    [self hideAllHUDsForView:view animated:YES];
    
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.detailsLabel.text = words;
//    hud.detailsLabel.font = tnPromptWordFont;
//    hud.detailsLabel.textColor = [UIColor whiteColor];
//    hud.bezelView.backgroundColor = tnPromptBoxBackGroundColor;
//    hud.bezelView.layer.cornerRadius = tnPromptBoxCornerRadius;
    hud.margin = tnPromptWordMargin;
    
    // 设置图片
    if (icon) {
        hud.customView = [[UIImageView alloc] initWithImage:icon];
    }
    
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:tnPromptBoxRemainTime];
}


+ (TNPromptBox *)showPrompttingBoxWithWords:(NSString *)words
{
    return [self showPrompttingBoxWithWords:words toView:nil];
}


+ (TNPromptBox *)showPrompttingBoxWithWords:(NSString *)words toView:(UIView *)view
{
    //if (!words.length) return nil;
    if (![[NSThread currentThread] isMainThread]) {
        return nil;
    }
    if (view == nil) view = tnAppWindow;
    
    
    // 快速显示一个提示信息
    TNPromptBox *hud = [TNPromptBox showHUDAddedTo:view animated:YES];
    hud.label.text = words;
    
    hud.mode = MBProgressHUDModeIndeterminate;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // YES代表需要蒙版效果
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:.2f];
    if (tnDeviceSystemVersion<9.0) {
        [UIActivityIndicatorView appearanceWhenContainedIn:[TNPromptBox class], nil];
    }else{
        [UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:@[[TNPromptBox class]]].color = [UIColor whiteColor];
    }
//    hud.bezelView.color = tnPromptBoxBackGroundColor;
    hud.margin = tnPromptWordMargin;
    
    return hud;
}


- (void)hidePrompttingBox
{
    [self hideAnimated:YES];
}

+ (void)hidePrompttingBoxs
{
    [self hidePrompttingBoxsForView:nil];
}

+ (void)hidePrompttingBoxsForView:(UIView *)view
{
    if (view == nil) view = tnAppWindow;
    [self hideAllHUDsForView:view animated:YES];
}

@end
