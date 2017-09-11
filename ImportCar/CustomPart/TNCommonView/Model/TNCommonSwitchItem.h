//
//  TNCommonSwitchItem.h
//  BaseProject
//
//  Created by Tony on 2017/8/4.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "TNCommonItem.h"

@interface TNCommonSwitchItem : TNCommonItem

@property (nonatomic,copy) void(^clickedSwitchBlock)(UISwitch *);

@end
