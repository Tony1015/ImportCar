//
//  UILabel+TNAdd.m
//  ImportCar
//
//  Created by Tony on 2017/9/7.
//  Copyright © 2017年 刘迪诗. All rights reserved.
//

#import "UILabel+TNAdd.h"

@implementation UILabel (TNAdd)

- (CGSize)tn_calculateLabelSizeWithMaxWidth:(CGFloat)maxWidth{
    CGRect rect = [self textRectForBounds:CGRectMake(0, 0, maxWidth, MAXFLOAT) limitedToNumberOfLines:0];
    return rect.size;
}

@end
