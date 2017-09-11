//
//  TNBaseResponse.m
//  anke
//
//  Created by Tony on 2017/8/29.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "TNBaseResponse.h"
#import "TNLoginViewController.h"

@implementation TNBaseResponse

- (void)judgeIfSuccess:(void(^)())success{
    if ([self.result isEqualToString:@"0"]) {
        if (success) {
            success();
        }
    }else{
        if ([self.msg isEqualToString:@"用户id不能为空"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登录" message:@"请确定先登录再进行此操作" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                TNLoginViewController *vc = [TNLoginViewController new];
                [tnAppWindow.rootViewController presentViewController:vc animated:YES completion:nil];
            }]];
            
            [tnAppWindow.rootViewController presentViewController:alert animated:YES completion:nil];
            return;
        }
        [TNPromptBox showPromptBoxWithWords:self.msg];
    }
};


@end
