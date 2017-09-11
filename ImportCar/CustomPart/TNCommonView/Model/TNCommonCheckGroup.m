//
//  TNCommonCheckGroup.m
//  BaseProject
//
//  Created by Tony on 2017/8/4.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "TNCommonCheckGroup.h"
#import "TNCommonCheckItem.h"

@implementation TNCommonCheckGroup

- (void)setCheckedIndex:(NSInteger)checkedIndex
{
    _checkedIndex = checkedIndex;
    
    // 屏蔽外面的SB行为(乱传参数行为)
    int count = self.items.count;
    if (checkedIndex < 0 || checkedIndex >= count) return;
    
    for (int i = 0; i<count; i++) {
        TNCommonCheckItem *item = (TNCommonCheckItem *)self.items[i];
        
        if (i == checkedIndex) {
            item.checked = YES;
        } else {
            item.checked = NO;
        }
    }
}

- (void)setItems:(NSArray *)items
{
    [super setItems:items];
    
    self.checkedIndex = self.checkedIndex;
}

@end
