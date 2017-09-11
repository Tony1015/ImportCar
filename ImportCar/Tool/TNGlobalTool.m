//
//  TNGlobalTool.m
//  BaseProject
//
//  Created by Tony on 2017/8/4.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "TNGlobalTool.h"

@implementation TNGlobalTool
+ (void)delayTime:(CGFloat)time showAction:(void(^)())outTimeBlock
{
    CGFloat delayInSeconds = time;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        outTimeBlock();
    });
}


@end
