//
//  TNCommonView.m
//  BaseProject
//
//  Created by Tony on 2017/8/4.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "TNCommonView.h"
#import "TNCommonCell.h"

@interface TNCommonView ()
@end

@implementation TNCommonView
- (NSMutableArray *)groups
{
    if (!_groups) {
        self.groups = [NSMutableArray array];
    }
    return _groups;
}

- (void)addGroup:(TNCommonGroup *)group
{
    [self.groups addObject:group];
}

- (void)addCheckGroup:(TNCommonCheckGroup *)group
{
    [self.groups addObject:group];
}

- (id)groupInSection:(int)section
{
    return self.groups[section];
}

// init 内部默认会调用 initWithNibName
// initWithStyle 内部默认会调用 initWithNibName
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame style:UITableViewStyleGrouped]) {
        [self setupTable];
    }
    return self;
}

/**
 *  设置tableview属性
 */
- (void)setupTable
{
    // 1.去掉分割线
//    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.showsVerticalScrollIndicator = NO;
    // 2.设置每一组头部尾部的高度
    self.sectionFooterHeight = 5;
    self.sectionHeaderHeight = 0;
    
    // 3.设置背景色
    self.backgroundView = nil;
    self.backgroundColor = tnBackgroundColor;
    
    //    self.contentInset : 增加滚动区域(内容)
    if (tnDeviceSystemVersion > 7.0) {
        self.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    }
    //    TNLog(@"viewDidLoad--%@", NSStringFromUIEdgeInsets(self.contentInset));
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TNCommonGroup *group = self.groups[section];
    return group.items.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    TNCommonGroup *group = self.groups[section];
    return group.titleFooter;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    TNCommonGroup *group = self.groups[section];
    return group.titleHead;
}

#pragma mark 每一行显示怎样的cell（内容）
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TNCommonCell *cell = [TNCommonCell cellWithTableView:tableView];
    TNCommonGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row]; // 传递cell显示的模型数据
    cell.indexPath = indexPath; // 传递cell所在的行
    
    
    [cell cellWithIndex:indexPath totalRows:group.items.count];//这里主要是定义cell的背景图片
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self deselectRowAtIndexPath:indexPath animated:YES];
    
    // 1.取出这行对应的模型
    TNCommonGroup *group = self.groups[indexPath.section];
    TNCommonItem *item = group.items[indexPath.row];
    
    
    if ([group isKindOfClass:[TNCommonCheckGroup class]]) {
        [(TNCommonCheckGroup *)group setCheckedIndex:indexPath.row];
        [self reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
    }
    
    // 2.判断有没有设置目标控制器
    if (item.destinationClass) {
        UIViewController *vc = [[item.destinationClass alloc] init];
        vc.title = item.title;
        [[self tn_getViewController].navigationController pushViewController:vc animated:YES];
    }
    
    // 3.判断有没有想要执行的操作(block)
    if (item.operation) {
        item.operation();
    }
}
@end
