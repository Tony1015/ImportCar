//
//  TNCommonCell.m
//  BaseProject
//
//  Created by Tony on 2017/8/4.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "TNCommonCell.h"
#import "TNCommonArrowItem.h"
#import "TNCommonSwitchItem.h"
#import "TNCommonLabelItem.h"
#import "TNCommonCheckItem.h"
#import "TNCommonCircleIconItem.h"
#import "TNRubberBadgeButton.h"

@interface TNCommonCell()

/**
 *  右边的提醒数字
 */
@property (strong, nonatomic) TNRubberBadgeButton *rightBadgeButton;
/**
 *  开关
 */
@property (strong, nonatomic) UISwitch *rightSwitch;
/**
 *  标签
 */
@property (strong, nonatomic) UILabel *rightLabel;

/**
 箭头
 打钩
 */
@property (nonatomic,strong) UIImageView *rightImageView;

@property (nonatomic, weak) UITableView *tableView;
@end

@implementation TNCommonCell
#pragma mark - 懒加载右边的view
- (UIImageView *)rightImageView{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _rightImageView;
}

- (TNRubberBadgeButton *)rightBadgeButton
{
    if (_rightBadgeButton == nil) {
        _rightBadgeButton = [[TNRubberBadgeButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        [self.contentView addSubview:self.rightBadgeButton];
    }
    return _rightBadgeButton;
}

- (UISwitch *)rightSwitch
{
    if (_rightSwitch == nil) {
        self.rightSwitch = [[UISwitch alloc] init];
        [self.rightSwitch addTarget:self action:@selector(clickedSwitch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightSwitch;
}

- (void)clickedSwitch:(UISwitch *)sender{
    TNCommonSwitchItem *item = (TNCommonSwitchItem *)self.item;
    if (item.clickedSwitchBlock){
        item.clickedSwitchBlock(sender);
    }
}

- (UILabel *)rightLabel
{
    if (_rightLabel == nil) {
        self.rightLabel = [[UILabel alloc] init];
        self.rightLabel.textColor = [UIColor lightGrayColor];
        self.rightLabel.font = [UIFont systemFontOfSize:13];
    }
    return _rightLabel;
}

#pragma mark - 初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"common";
    TNCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TNCommonCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.tableView = tableView;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 1.设置文字的字体
        self.textLabel.highlightedTextColor = self.textLabel.textColor;
        self.detailTextLabel.textColor = [UIColor lightGrayColor];
        self.detailTextLabel.highlightedTextColor = self.detailTextLabel.textColor;
        
        // 2.设置cell的背景
        // backgroundView的优先级 > backgroundColor
        self.backgroundColor = [UIColor whiteColor];
        self.selectedBackgroundView = [[UIImageView alloc] init];
        self.backgroundView = [[UIImageView alloc] init];
    }
    return self;
}

#pragma mark - setter
- (void)setItem:(TNCommonItem *)item
{
    _item = item;
    
    // 1.设置图标
    if(item.icon){
        if(item.icon && ([item.icon hasPrefix:@"http://"] ||[item.icon hasPrefix:@"https://"])){
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.icon] placeholderImage:[UIImage imageNamed:@""]];
        }else{
            self.imageView.image = [UIImage imageNamed:item.icon];
        }
    }
    
    if ([item isKindOfClass:[TNCommonCircleIconItem class]]) {
        CGRect frame = self.imageView.frame;
        TNCommonCircleIconItem *circelItem = (TNCommonCircleIconItem*)self.item;
        frame.size.width = circelItem.imageWidth;
        frame.size.height = circelItem.imageWidth;
        frame.origin.y = (self.height - circelItem.imageWidth)*0.5;
        self.imageView.frame = frame;
        tnCornerRadius(self.imageView, circelItem.imageWidth*0.5);
        
        
        self.textLabel.font = tnBoldFont(16);
        self.detailTextLabel.font = tnSystemFont(12);
    }else{
        self.textLabel.font = tnSystemFont(15);
        self.detailTextLabel.font = tnSystemFont(11);
    }
    // 2.设置标题
    self.textLabel.text = item.title;
    
    // 3.设置子标题
    self.detailTextLabel.text = item.subTitle;
    
    
    // 显示提醒数字
    self.rightBadgeButton.badgeValue = self.item.badgeValue;
    
    // 4.设置右边显示的控件
    [self setupRightView];
}

/**
 *  设置右边显示的控件
 */
- (void)setupRightView
{
    if ([self.item isKindOfClass:[TNCommonArrowItem class]]) {
        // 显示箭头
        
        self.rightImageView.image = [[UIImage imageNamed:@"common_icon_arrow"] tn_changeImageColorTo:tnColor(160, 160, 160, 1)];
        
        self.accessoryView = self.rightImageView;
//        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    } else if ([self.item isKindOfClass:[TNCommonSwitchItem class]]) {
        // 显示开关
        
        self.accessoryView = self.rightSwitch;
    } else if ([self.item isKindOfClass:[TNCommonLabelItem class]]) {
        // 显示label
        self.accessoryView = self.rightLabel;
        // 设置label的文字
        TNCommonLabelItem *labelItem = (TNCommonLabelItem *)self.item;
        self.rightLabel.text = labelItem.text;
        
        // 计算尺寸
        self.rightLabel.size = [labelItem.text sizeWithAttributes:@{NSFontAttributeName:self.rightLabel.font}];
    } else if ([self.item isKindOfClass:[TNCommonCheckItem class]]) {
        // 显示打钩
        TNCommonCheckItem *checkItem = (TNCommonCheckItem *)self.item;
        [self.rightImageView setImage:[UIImage imageNamed:@"common_icon_checkmark"]];
        if (checkItem.isChecked) {
            self.accessoryView = self.rightImageView;
        } else {
            
            self.accessoryView = nil;
        }
    } else { // 右边不需要显示任何东西
        self.accessoryView = nil;
    }
}

#pragma mark - 设置cell的背景图片
-(void)cellWithIndex:(NSIndexPath *)indexPath totalRows:(NSInteger)rows{
    
//    self.backgroundColor = [UIColor yellowColor];
//    // 1.取出背景view
//    UIImageView *bg = (UIImageView *)self.backgroundView;
//    UIImageView *selectedBg = (UIImageView *)self.selectedBackgroundView;
//
//    // 2.根据cell显示的具体位置, 来设置背景view显示的图片
//    // 获得cell这组的总行数
//    NSInteger totalRows = [self.tableView numberOfRowsInSection:indexPath.section];
//    
//    if (totalRows == 1) { // 这组只有1行
//        bg.image = [UIImage tn_resizableImage:@"common_card_background"];
//        selectedBg.image = [UIImage tn_resizableImage:@"common_card_background_highlighted"];
//    } else if (indexPath.row == 0) { // 这组的首行(第0行)
//        bg.image = [UIImage tn_resizableImage:@"common_card_top_background"];
//        selectedBg.image = [UIImage tn_resizableImage:@"common_card_top_background_highlighted"];
//    } else if (indexPath.row == totalRows - 1) { // 这组的末行(最后1行)
//        bg.image = [UIImage tn_resizableImage:@"common_card_bottom_background"];
//        selectedBg.image = [UIImage tn_resizableImage:@"common_card_bottom_background_highlighted"];
//    } else {
//        bg.image = [UIImage tn_resizableImage:@"common_card_middle_background"];
//        selectedBg.image = [UIImage tn_resizableImage:@"common_card_middle_background_highlighted"];
//    }
}

#pragma mark - 为了拦截frame的设置, 在这里统一设置所有cell的frame
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

#pragma mark - 布置子控件位置
-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.item.badgeValue>0) {
        self.rightBadgeButton.centerY = self.contentView.height*0.5;
        self.rightBadgeButton.x = self.contentView.width - self.rightBadgeButton.width -5;
        [self.rightBadgeButton setNeedsLayout];
    }
    
    if([self.item isKindOfClass:[TNCommonCircleIconItem class]]){
        
        CGRect textLabelFrame = self.textLabel.frame;
        textLabelFrame.origin.x = CGRectGetMaxX(self.imageView.frame)+10;
        self.textLabel.frame = textLabelFrame;
        
        self.detailTextLabel.x = self.textLabel.x;
        self.detailTextLabel.y = CGRectGetMaxY(self.textLabel.frame) + 2;
    }else{
        if (self.item.subTitle) {
            self.textLabel.centerY = self.boundsCenter.y;
            self.detailTextLabel.x = CGRectGetMaxX(self.textLabel.frame) + 10;
            self.detailTextLabel.centerY = self.textLabel.centerY;
        }
    }
}

@end
