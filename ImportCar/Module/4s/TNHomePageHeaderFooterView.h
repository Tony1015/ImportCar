//
//  TNHomePageHeaderFooterView.h
//  ImportCar
//
//  Created by Tony on 2017/9/11.
//  Copyright © 2017年 刘迪诗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TNHomePageHeaderFooterView : UITableViewHeaderFooterView


@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, strong) Class destinationClass;


+ (instancetype)viewForTabelView:(UITableView *)tableView withTitle:(NSString *)title imageName:(NSString *)imageName destinationClass:(Class)destinationClass;

@end
