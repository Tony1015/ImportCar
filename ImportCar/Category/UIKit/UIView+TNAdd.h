//
//  UIView+TNAdd.h
//  BaseProject
//
//  Created by Tony on 2017/8/4.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TNAdd)


#pragma mark - UIView + Frame
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGSize size;

@property (nonatomic,assign) CGPoint origin;

@property(nonatomic,assign) CGFloat centerX;

@property(nonatomic,assign)CGFloat centerY;

@property (nonatomic,assign) CGPoint boundsCenter;


- (UIViewController *)tn_getViewController;

/**
 截图
 */
- (UIImage*)tn_screenshot;


@end
