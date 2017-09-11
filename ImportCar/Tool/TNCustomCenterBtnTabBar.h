//
//  TNCustomCenterBtnTabBar.h
//  ImportCar
//
//  Created by Tony on 2017/9/7.
//  Copyright © 2017年 刘迪诗. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TNCustomCenterBtnTabBar;

@protocol TNCustomCenterBtnTabBarDelegate <UITabBarDelegate>

- (void)tabBarClickedCenterBtn:(TNCustomCenterBtnTabBar *)tabBar;

@end

@interface TNCustomCenterBtnTabBar : UITabBar

@property (nonatomic, weak) id <TNCustomCenterBtnTabBarDelegate> delegate;

@end
