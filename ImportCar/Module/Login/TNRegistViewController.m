//
//  TNRegistViewController.m
//  ImportCar
//
//  Created by Tony on 2017/9/8.
//  Copyright © 2017年 刘迪诗. All rights reserved.
//

#import "TNRegistViewController.h"
#import "TNUnderLineButton.h"

@interface TNRegistViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *companyUserBtn;
@property (weak, nonatomic) IBOutlet TNUnderLineButton *descriptionBtn;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendVerificationCodeBtn;

@end

@implementation TNRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    [self commonInit];
}

- (void)commonInit {
    tnCornerRadius(self.sendVerificationCodeBtn, 4);
    self.sendVerificationCodeBtn.backgroundColor = tnMainColor;
    self.submitBtn.backgroundColor = tnMainColor;
    tnCornerRadius(self.submitBtn, 4);
    [self.descriptionBtn setTitleColor:tnMainColor forState:UIControlStateNormal];
    
    
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
