//
//  TNHomePageHeaderFooterView.m
//  ImportCar
//
//  Created by Tony on 2017/9/11.
//  Copyright © 2017年 刘迪诗. All rights reserved.
//

#import "TNHomePageHeaderFooterView.h"
#import "TNBaseButton.h"

@interface TNHomePageHeaderFooterView ()

@property (nonatomic, weak) TNBaseButton *titleBtn;

@end


@implementation TNHomePageHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = tnColorWhite;
        
        TNBaseButton *titleBtn = [TNBaseButton new];
        self.titleBtn = titleBtn;
        
        titleBtn.titleLabel.font = tnBoldFont(14);
        [titleBtn setTitleColor:tnColorBlack forState:UIControlStateNormal];
        [self.contentView addSubview:titleBtn];
        [titleBtn horizontalCenterImageAndTitle:2];
        [titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(10);
        }];
        TNBaseButton *moreBtn = [[TNBaseButton alloc]init];
        moreBtn.titleLabel.font = tnSystemFont(13);
        [moreBtn setTitle:@"more" forState:UIControlStateNormal];
        [moreBtn setImage:[UIImage imageNamed:@"more-more"] forState:UIControlStateNormal];
        [moreBtn setTitleColor:tnColorLightGray forState:UIControlStateNormal];
        [moreBtn addTarget:self action:@selector(clickedMoreBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:moreBtn];
        [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-15);
        }];
        [moreBtn horizontalCenterTitleAndImage:2];
    }
    return self;
}

- (void)clickedMoreBtn{
    UIViewController *vc = [[self.destinationClass alloc] init];
    [[self tn_getViewController].navigationController pushViewController:vc animated:YES];
}

+ (instancetype)viewForTabelView:(UITableView *)tableView withTitle:(NSString *)title imageName:(NSString *)imageName destinationClass:(Class)destinationClass{
    
    NSString *reuseId = [NSString stringWithFormat:@"tn_%@_%@_reuseId",tnBundleId,NSStringFromClass(tableView.class)];
    TNHomePageHeaderFooterView *view = [[self alloc] initWithReuseIdentifier:reuseId];
    view.title = title;
    view.imageName = imageName;
    view.destinationClass = destinationClass;
    return view;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    [self.titleBtn setTitle:title forState:UIControlStateNormal];
}

- (void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    if ([imageName hasPrefix:@"http://"]) {
        [self.titleBtn sd_setImageWithURL:[NSURL URLWithString:imageName] forState:UIControlStateNormal placeholderImage:[UIImage new]];
    }else{
        [self.titleBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
}



@end
