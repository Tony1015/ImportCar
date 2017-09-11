//
//  TNChooseController.m
//  BaseProject
//
//  Created by Tony on 2017/8/15.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "TNChooseController.h"

#import "TNLoginViewController.h"

#import "TNTabBarController.h"

@interface TNChooseController ()

@end

@implementation TNChooseController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self presentViewController:[TNTabBarController new] animated:NO completion:nil];
    tnAppWindow.rootViewController = [TNLoginViewController new];
    
    
    
    
    
    // Do any additional setup after loading the view.
}


- (void)judgeVersion{
    NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
    
    // 从沙盒中取出上次存储的软件版本号(取出用户上次的使用记录)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults objectForKey:versionKey];
    
    // 获得当前打开软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([currentVersion isEqualToString:lastVersion]) {
        // 当前版本号 == 上次使用的版本
        
    } else { // 当前版本号 != 上次使用的版本：显示版本新特性
        
        
        // 存储这次使用的软件版本
        [defaults setObject:currentVersion forKey:versionKey];
        [defaults synchronize];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
