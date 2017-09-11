//
//  UIButton+TNAdd.m
//  BaseProject
//
//  Created by Tony on 2017/8/14.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "UIButton+TNAdd.h"

@implementation UIButton (TNAdd)

- (instancetype)tn_buttonWithTarget:(id)target action:(SEL)sel{
//    self.buttonType = UIButtonTypeCustom;
    [self addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    [self setExclusiveTouch:YES];
    
    return self;
}


@end
