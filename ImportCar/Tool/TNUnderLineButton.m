//
//  TNUnderLineButton.m
//  ImportCar
//
//  Created by Tony on 2017/9/7.
//  Copyright © 2017年 刘迪诗. All rights reserved.
//

#import "TNUnderLineButton.h"

@implementation TNUnderLineButton

- (void)drawRect:(CGRect)rect {
    CGRect textRect = self.titleLabel.frame;
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(contextRef, 1);
    CGContextSetStrokeColorWithColor(contextRef, self.titleLabel.textColor.CGColor);
    CGContextMoveToPoint(contextRef, textRect.origin.x, CGRectGetMaxY(textRect));
    CGContextAddLineToPoint(contextRef, CGRectGetMaxX(textRect), CGRectGetMaxY(textRect));
    CGContextClosePath(contextRef);
    CGContextDrawPath(contextRef, kCGPathStroke);
}

@end
