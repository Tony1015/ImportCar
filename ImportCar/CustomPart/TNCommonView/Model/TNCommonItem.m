//
//  TNCommonItem.m
//  BaseProject
//
//  Created by Tony on 2017/8/4.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "TNCommonItem.h"

@implementation TNCommonItem
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon
{
    TNCommonItem *item = [[self alloc] init];
    item.title = title;
    item.icon = icon;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithTitle:title icon:nil];
}


-(void)setTitle:(NSString *)title{
    _title = title;
}

@end
