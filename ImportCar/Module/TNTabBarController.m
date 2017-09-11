//
//  TNTabBarController.m
//  anke
//
//  Created by Tony on 2017/8/16.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "TNTabBarController.h"
#import "TNBaseNavigationController.h"
#import "TNCustomCenterBtnTabBar.h"
#import "TNBaseButton.h"

#import "TNHomePageViewController.h"
#import "TNSourceViewController.h"

@interface TNTabBarController ()<TNCustomCenterBtnTabBarDelegate>


@end

@implementation TNTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = tnBackgroundColor;
    TNCustomCenterBtnTabBar *tabBar = [[TNCustomCenterBtnTabBar alloc]init];
    [self setValue:tabBar forKey:@"tabBar"];
    
    self.tabBar.barTintColor = [UIColor clearColor];
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tnScreenWidth, 49)];
    backgroundView.backgroundColor = tnColor(246, 246, 246, 1);
    [self.tabBar addSubview:backgroundView];
    [self.tabBar setTintColor:tnMainColor];
    
    [self setChildViewControllers];
}

//禁止屏幕转动
- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
}


- (void)setChildViewControllers{
    [self addChildViewControllerWithController:[TNHomePageViewController new] title:@"现车" image:[UIImage imageNamed:@"tab_home_normal"] selectedImage:[UIImage imageNamed:@"tab_home_selected"]];
    [self addChildViewControllerWithController:[TNSourceViewController new] title:@"车源" image:[UIImage imageNamed:@"tab_cheyuan_normal"] selectedImage:[UIImage imageNamed:@"tab_cheyuan_selected"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (void)addChildViewControllerWithController:(UIViewController *)controller title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selImage{
    TNBaseNavigationController *navi = [[TNBaseNavigationController alloc]initWithRootViewController:controller];
    [self addChildViewController:navi];
    navi.tabBarItem.title = title;
    navi.tabBarItem.image = image;
    navi.tabBarItem.selectedImage = selImage;
}

static UIWindow *tabBarShowWindow;
static UIView *tabBarShowContentView;
static CGFloat contentViewHeight = 300;

#pragma mark ----TNCustomCenterBtnTabBarDelegate
- (void)tabBarClickedCenterBtn:(TNCustomCenterBtnTabBar *)tabBar{
    tabBarShowWindow = [[UIWindow alloc]initWithFrame:self.view.bounds];
    tabBarShowWindow.hidden = NO;
    tabBarShowWindow.backgroundColor = tnColor(1, 1, 1, 0.2);
    tabBarShowContentView = [[UIView alloc]initWithFrame:CGRectMake(0, tnScreenHeight, tnScreenWidth, contentViewHeight)];
    [tabBarShowWindow addSubview:tabBarShowContentView];
    tabBarShowContentView.backgroundColor = tnColorWhite;
    
    
    POPSpringAnimation *animation = [POPSpringAnimation animation];
    animation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    animation.fromValue = [NSValue valueWithCGRect:CGRectMake(0, tnScreenHeight, tnScreenWidth, contentViewHeight)];
    animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, tnScreenHeight - contentViewHeight, tnScreenWidth, contentViewHeight)];
    animation.springBounciness = 10;
    animation.springSpeed = 6;
    
    [tabBarShowContentView pop_addAnimation:animation forKey:nil];
    
    TNBaseButton *removeBtn = [[TNBaseButton alloc]init];
    [removeBtn setImage:[UIImage imageNamed:@"shezhi_icon_qingchu_normal"] forState:UIControlStateNormal];
    [removeBtn addTarget:self action:@selector(removeTabBarShowWindow) forControlEvents:UIControlEventTouchUpInside];
    [tabBarShowContentView addSubview:removeBtn];
    [removeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(35);
        make.bottom.equalTo(tabBarShowContentView).offset(-10);
        make.centerX.equalTo(tabBarShowContentView);
    }];
    [removeBtn onlyImageButtonSizeToFit];
    
    TNBaseButton *releaseSourceBtn = [[TNBaseButton alloc]init];
    [releaseSourceBtn setTitleColor:tnColorDarkGray forState:UIControlStateNormal];
    [tabBarShowContentView addSubview:releaseSourceBtn];
    [releaseSourceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(100);
        make.right.equalTo(tabBarShowContentView.mas_centerX).offset(-55);
        make.centerY.equalTo(tabBarShowContentView);
    }];
    [releaseSourceBtn verticalCenterImageAndTitle:2];
    [releaseSourceBtn setTitle:@"车源发布" forState:UIControlStateNormal];
    releaseSourceBtn.titleLabel.font = tnSystemFont(14);
    [releaseSourceBtn setImage:[UIImage imageNamed:@"pop_button_cheyuanfabu_normal"] forState:UIControlStateNormal];
    
    
    TNBaseButton *releaseSearchBtn = [[TNBaseButton alloc]init];
    [releaseSearchBtn setTitleColor:tnColorDarkGray forState:UIControlStateNormal];
    [tabBarShowContentView addSubview:releaseSearchBtn];
    [releaseSearchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(100);
        make.left.equalTo(tabBarShowContentView.mas_centerX).offset(55);
        make.centerY.equalTo(tabBarShowContentView);
    }];
    [releaseSearchBtn verticalCenterImageAndTitle:2];
    [releaseSearchBtn setTitle:@"寻车发布" forState:UIControlStateNormal];
    releaseSearchBtn.titleLabel.font = tnSystemFont(14);
    [releaseSearchBtn setImage:[UIImage imageNamed:@"pop_button_xunchefabu_normal"] forState:UIControlStateNormal];
    
}

- (void)removeTabBarShowWindow{
    POPSpringAnimation *animation = [POPSpringAnimation animation];
    animation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, tnScreenHeight, tnScreenWidth, contentViewHeight)];
    animation.springBounciness = 0;
    animation.springSpeed = 10;
    animation.completionBlock = ^(POPAnimation *anim, BOOL finished){
        if (finished) {
            tabBarShowWindow.hidden = YES;
            tabBarShowContentView = nil;
            tabBarShowWindow = nil;
        }
    };
    [tabBarShowContentView pop_addAnimation:animation forKey:nil];
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
