//
//  TNBaseTableView.m
//  anke
//
//  Created by Tony on 2017/9/7.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "TNBaseTableView.h"
#import "TNBaseButton.h"

@interface TNBaseTableView ()
@property (nonatomic, strong) TNBaseButton *noDataButton;

@end

@implementation TNBaseTableView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.tableFooterView = [UIView new];
    }
    return self;
}

- (TNBaseButton *)noDataButton{
    if (!_noDataButton) {
        _noDataButton = [[TNBaseButton alloc]init];
        [_noDataButton setImage:[UIImage imageNamed:@"暂无数据"] forState:UIControlStateNormal];
//        [_noDataButton setTitle:@"暂无数据" forState:UIControlStateNormal];
        [_noDataButton setTitleColor:tnColorDarkGray forState:UIControlStateNormal];
        [_noDataButton verticalCenterImageAndTitle:2];
    }
    return _noDataButton;
}


- (void)reloadData{
    [super reloadData];
    NSInteger aaa = [self numberOfRowsInSection:0];
    if (aaa<1) {
        if(!self.noDataButton.superview){
            [self addSubview:self.noDataButton];
            [self.noDataButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.centerY.equalTo(self).offset(-32);
            }];
        }
    }else{
        [self.noDataButton removeFromSuperview];
    }
}








@end
