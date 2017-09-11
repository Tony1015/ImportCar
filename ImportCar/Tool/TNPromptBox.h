//
//  TNPromptBox.h
//  BaseProject
//
//  Created by Tony on 2017/8/7.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import <MBProgressHUD.h>

#define tnPromptBoxRemainTime 1.0

@interface TNPromptBox : MBProgressHUD

/**
 * 自动隐藏的提示框
 * param words 提示语
 * param view 父视图，默认为appWindow
 * param icon 提示图片，默认没有
 */
+ (void)showPromptBoxWithWords:(NSString *)words;
+ (void)showPromptBoxWithWords:(NSString *)words toView:(UIView *)view;
+ (void)showPromptBoxWithWords:(NSString *)words icon:(UIImage *)icon;
+ (void)showPromptBoxWithWords:(NSString *)words icon:(UIImage *)icon toView:(UIView *)view;



/**
 * 手动隐藏的提示框---带菊花的
 * param words 提示语
 * param view 父视图，默认为appWindow
 * param icon 提示图片，默认没有
 */
+ (TNPromptBox *)showPrompttingBoxWithWords:(NSString *)words;
+ (TNPromptBox *)showPrompttingBoxWithWords:(NSString *)words toView:(UIView *)view;


/**
 *  隐藏单个提示框
 */
- (void)hidePrompttingBox;
/**
 *  隐藏keyWindow上所有的提示框
 */
+ (void)hidePrompttingBoxs;
/**
 *  隐藏view上所有的提示框
 *
 *  @param view 父视图
 */
+ (void)hidePrompttingBoxsForView:(UIView *)view;

@end
