//
//  TNCommonCell.h
//  BaseProject
//
//  Created by Tony on 2017/8/4.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TNCommonItem, TNCommonCell;


@protocol TNCommonCellDelegate <NSObject>


@end

@interface TNCommonCell : UITableViewCell

-(void)cellWithIndex:(NSIndexPath *)indexPath totalRows:(NSInteger)rows;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) TNCommonItem *item;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end
