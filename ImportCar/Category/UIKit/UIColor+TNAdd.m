//
//  UIColor+TNAdd.m
//  BaseProject
//
//  Created by Tony on 2017/8/13.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "UIColor+TNAdd.h"

@implementation UIColor (TNAdd)

+ (UIColor *) tn_colorWithHex:(NSUInteger)hex {
    
    float r = (hex & 0xff000000) >> 24;
    float g = (hex & 0x00ff0000) >> 16;
    float b = (hex & 0x0000ff00) >> 8;
    float a = (hex & 0x000000ff);
    
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/255.0];
}

@end
