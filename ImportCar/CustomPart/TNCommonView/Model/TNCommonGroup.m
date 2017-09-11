//
//  TNCommonGroup.m
//  BaseProject
//
//  Created by Tony on 2017/8/4.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "TNCommonGroup.h"

@implementation TNCommonGroup
+ (instancetype)group
{
    return [[self alloc] init];
}


+ (instancetype)groupWithItems:(NSArray<TNCommonItem *>*)items{
    TNCommonGroup *group = [self group];
    group.items = items;
    return group;
}

@end
