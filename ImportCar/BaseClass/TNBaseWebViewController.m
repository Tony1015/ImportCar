//
//  TNBaseWebViewController.m
//  anke
//
//  Created by Tony on 2017/8/30.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "TNBaseWebViewController.h"

@interface TNBaseWebViewController ()

@end

@implementation TNBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    
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
