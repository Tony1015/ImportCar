//
//  TNGlobalTool.h
//  BaseProject
//
//  Created by Tony on 2017/8/4.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TNGlobalTool : NSObject

/**
 延迟执行
 */
+ (void)delayTime:(CGFloat)time showAction:(void(^)())outTimeBlock;


@end
