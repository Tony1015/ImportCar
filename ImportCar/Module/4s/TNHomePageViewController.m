//
//  TNHomePageViewController.m
//  ImportCar
//
//  Created by Tony on 2017/9/7.
//  Copyright © 2017年 刘迪诗. All rights reserved.
//

#import "TNHomePageViewController.h"
#import <PYSearch.h>
#import "TNBaseButton.h"
#import "TNIntroductionView.h"
#import "TNMenuView.h"
#import "TNHomePageHeaderFooterView.h"

@interface TNHomePageViewController ()<PYSearchViewControllerDelegate, UITableViewDelegate, UITableViewDataSource, TNMenuViewDelegate>

@property (nonatomic, weak) TNIntroductionView *adView;

@property (nonatomic, weak) TNMenuView *menuView;

@property (nonatomic, strong) UIView *heardView;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;



@end

@implementation TNHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}



- (void)commonInit{
    //navigationItem
    TNBaseButton *searchBtn = [[TNBaseButton alloc]initWithFrame:CGRectMake(0, 0, tnScreenWidth - 60, 28)];
    self.navigationItem.titleView = searchBtn;
//    searchBtn.imageView.contentMode = UIViewContentModeCenter;
    tnCornerRadius(searchBtn, 6);
    [searchBtn setImage:[[UIImage imageNamed:@"search"] tn_changeImageColorTo:tnColorLightGray] forState:UIControlStateNormal];
    searchBtn.backgroundColor = tnColorWhite;
    [searchBtn horizontalLeftImageAndTitle:5];
    [searchBtn addTarget:self action:@selector(clickedSearhBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"xinfeng"] style:UIBarButtonItemStylePlain target:self action:@selector(clickedRightBarItem)];
    
    //adView
    self.heardView = [[UIView alloc]init];
    self.heardView.backgroundColor = tnColorYellow;
    TNIntroductionView *adView = [[TNIntroductionView alloc] initWithFrame:CGRectMake(0, 0, tnScreenWidth, 140)];
    self.adView = adView;
    [self.heardView addSubview:adView];
    
    TNMenuView *menuView = [[TNMenuView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(adView.frame), tnScreenWidth, 140)];
    menuView.showSliderView = YES;
    menuView.delegate = self;
    menuView.itemWidth = tnScreenWidth/4.0;
    menuView.columnsCount = 2;
    self.menuView = menuView;
    [self.heardView addSubview:menuView];
    array = @[@"法拉利", @"宝马", @"奔驰", @"奥迪", @"丰田", @"途乐", @"玛莎拉蒂", @"宝马", @"奔驰", @"奥迪", @"宝马", @"奔驰", @"奥迪"];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, tnScreenWidth, tnScreenHeight - tnTabbarHeight) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
}

- (void)clickedSearhBtn{
    PYSearchViewController *searchVC = [[PYSearchViewController alloc]init];
    searchVC.hotSearchTitle = @"热门品牌";
    searchVC.hotSearches = @[@"法拉利", @"宝马", @"奔驰", @"奥迪", @"丰田", @"途乐", @"玛莎拉蒂"];
    searchVC.delegate = self;
    [self.navigationController pushViewController:searchVC animated:NO];
    
    [searchVC.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_button_back"] style:UIBarButtonItemStylePlain target:self action:@selector(popBack)]];
    
}

- (void)popBack{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)clickedRightBarItem{
    
}



#pragma mark ---TNMenuViewDelegate
- (NSInteger)menuViewNumberOfItems:(TNMenuView *)menuView{
    return 11;
}

static NSArray *array;

- (UIView *)menuView:(TNMenuView *)menuView viewAtIndex:(NSInteger)index{
    
    TNBaseButton *btn = [[TNBaseButton alloc]init];
    [btn setTitle:array[index] forState:UIControlStateNormal];
    return btn;
}


#pragma mark ---UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return self.heardView;
    }
    
    if (section == 1){
        return [TNHomePageHeaderFooterView viewForTabelView:self.tableView withTitle:@"限时抢购" imageName:@"time" destinationClass:[UIViewController class]];
    }else if (section == 2){
        return [TNHomePageHeaderFooterView viewForTabelView:self.tableView withTitle:@"热门品牌" imageName:@"hot-brand" destinationClass:[UIViewController class]];
    }else if (section ==3){
        return [TNHomePageHeaderFooterView viewForTabelView:self.tableView withTitle:@"推荐车型" imageName:@"good" destinationClass:[UIViewController class]];
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 280;
    }
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
//- (nullable UITableViewHeaderFooterView *)headerViewForSection:(NSInteger)section NS_AVAILABLE_IOS(6_0){
//    
//    return nil;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseId = @"cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    return cell;
}




@end
