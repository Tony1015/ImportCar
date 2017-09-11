//
//  TNSetPasswordViewController.m
//  ImportCar
//
//  Created by Tony on 2017/9/8.
//  Copyright © 2017年 刘迪诗. All rights reserved.
//

#import "TNSetPasswordViewController.h"
#import "TNUnderLineButton.h"

@interface TNSetPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *comfirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet TNUnderLineButton *setBtn;

@end

@implementation TNSetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
    self.title = @"设置登录密码";
}


- (void)commonInit{
    [self.setBtn setTitleColor:tnMainColor forState:UIControlStateNormal];
    self.submitBtn.backgroundColor = tnMainColor;
    tnCornerRadius(self.submitBtn, 4);
    
}

- (IBAction)clickedSubmitBtn:(id)sender {
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
