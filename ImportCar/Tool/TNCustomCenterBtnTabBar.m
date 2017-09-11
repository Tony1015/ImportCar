//
//  TNCustomCenterBtnTabBar.m
//  ImportCar
//
//  Created by Tony on 2017/9/7.
//  Copyright © 2017年 刘迪诗. All rights reserved.
//

#import "TNCustomCenterBtnTabBar.h"
#import "TNBaseButton.h"

#define centerBtnWH 40

@interface TNCustomCenterBtnTabBar ()
@property (nonatomic, strong) TNBaseButton *centerButton;
@end

@implementation TNCustomCenterBtnTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.centerButton = [[TNBaseButton alloc]init];
        [self.centerButton setImage:[UIImage imageNamed:@"tab_jiahao_button"] forState:UIControlStateNormal];
        self.centerButton.width = centerBtnWH;
        self.centerButton.height = centerBtnWH;
        [self.centerButton addTarget:self action:@selector(clickedCenterBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.centerButton onlyImageButtonSizeToFit];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self addSubview:self.centerButton];
    self.centerButton.center = self.boundsCenter;
    CGFloat tabBarBtnWidth = self.width/5.0;
    int i = 0;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            view.x = i*tabBarBtnWidth;
            view.width = tabBarBtnWidth;
            i++;
            if (i==2) {
                i++;
            }
        }
    }
}

- (void)clickedCenterBtn{
    if ([self.delegate respondsToSelector:@selector(tabBarClickedCenterBtn:)]) {
        [self.delegate tabBarClickedCenterBtn:self];
    }
}

- (void)setHidden:(BOOL)hidden{
    [super setHidden:hidden];
}


@end
