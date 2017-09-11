//
//  TNBaseTableViewCell.m
//  BaseProject
//
//  Created by Tony on 2017/8/4.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "TNBaseTableViewCell.h"

@implementation TNBaseTableViewCell

+ (instancetype)cellWithTableView:(UITableView*)tableView{
    NSString *identifier = [NSString stringWithFormat:@"tn_%@_%@_reuseId",tnBundleId,NSStringFromClass(tableView.class)];
    TNBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil) {
        cell = [[TNBaseTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}



@end
