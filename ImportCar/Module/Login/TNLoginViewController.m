//
//  TNLoginViewController.m
//  ImportCar
//
//  Created by Tony on 2017/9/7.
//  Copyright © 2017年 刘迪诗. All rights reserved.
//

#import "TNLoginViewController.h"
#import "TNUnderLineButton.h"
#import "TNTabBarController.h"
#import "TNRegistViewController.h"
#import "TNSetPasswordViewController.h"


#define imageViewH 100

@interface TNLoginViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextfiled;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (weak, nonatomic) IBOutlet UIButton *getVerificationCodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTextField;

@property (weak, nonatomic) IBOutlet TNUnderLineButton *toPassWordBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (weak, nonatomic) IBOutlet TNUnderLineButton *toVerificationCodeBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verificationCodeViewX;


@end

@implementation TNLoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = tnAppWindow.bounds;
    [self commonInit];
}


- (void)commonInit{
    self.view.backgroundColor = tnBackgroundColor;
    
    [self.toPassWordBtn setTitleColor:tnMainColor forState:UIControlStateNormal];
    [self.toVerificationCodeBtn setTitleColor:tnMainColor forState:UIControlStateNormal];
    
    self.getVerificationCodeBtn.backgroundColor = tnMainColor;
    [self.getVerificationCodeBtn setTitleColor:tnColorWhite forState:UIControlStateNormal];
    [self.getVerificationCodeBtn setTitle:@"获取验证" forState:UIControlStateNormal];
    tnCornerRadius(self.getVerificationCodeBtn, 4);
    tnCornerRadius(self.loginBtn, 4);
    tnCornerRadius(self.registerBtn, 4);
    self.loginBtn.backgroundColor = tnMainColor;
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:tnColorWhite forState:UIControlStateNormal];
    self.registerBtn.layer.borderColor = tnMainColor.CGColor;
    self.registerBtn.layer.borderWidth = 1;
    [self.registerBtn setTitleColor:tnMainColor forState:UIControlStateNormal];
    [self.registerBtn setTitle:@"注册" forState:UIControlStateNormal];

    
    
    tnCornerRadius(self.imageView, imageViewH*0.5);
    self.imageView.backgroundColor = tnColorYellow;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.width.mas_equalTo(imageViewH);
        make.bottom.equalTo(self.phoneTextfiled.mas_top).offset(-30);
    }];

}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)clickedGetVerificationCodeBtn:(id)sender {
}
- (IBAction)clickedToPasswordBtn:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        self.verificationCodeViewX.constant = -self.view.width;
        [self.view layoutIfNeeded];
    }];
}
- (IBAction)clickedLoginBtn:(id)sender {
    tnAppWindow.rootViewController = [TNTabBarController new];
}
- (IBAction)clickedRegisterBtn:(id)sender {
    TNRegistViewController *vc = [TNRegistViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)clickedToVerificationCodeBtn:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        self.verificationCodeViewX.constant = 0;
        [self.view layoutIfNeeded];
    }];
}


@end





