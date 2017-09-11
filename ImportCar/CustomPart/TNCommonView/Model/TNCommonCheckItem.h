//
//  TNCommonCheckItem.h
//  BaseProject
//
//  Created by Tony on 2017/8/4.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "TNCommonItem.h"

@interface TNCommonCheckItem : TNCommonItem
/** 标记这个item是否要打钩 */
@property (nonatomic, assign, getter = isChecked) BOOL checked;

@end
