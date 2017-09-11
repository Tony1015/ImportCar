//
//  TNCommonView.h
//  BaseProject
//
//  Created by Tony on 2017/8/4.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TNCommonGroup.h"
#import "TNCommonCheckGroup.h"
#import "TNCommonItem.h"
#import "TNCommonCircleIconItem.h"


@interface TNCommonView : UITableView

@property (nonatomic, strong) NSMutableArray *groups;

- (void)addGroup:(TNCommonGroup *)group;

- (void)addCheckGroup:(TNCommonCheckGroup *)group;

- (id)groupInSection:(int)section;

@end
