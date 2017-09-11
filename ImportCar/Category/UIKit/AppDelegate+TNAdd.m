//
//  AppDelegate+TNAdd.m
//  BaseProject
//
//  Created by Tony on 2017/8/4.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "AppDelegate+TNAdd.h"

@implementation AppDelegate (TNAdd)

- (void)tn_windowSetRootViewController:(UIViewController *)viewController{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];
}

@end
