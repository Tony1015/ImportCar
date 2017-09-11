//
//  TNMenuView.h
//  ImportCar
//
//  Created by Tony on 2017/9/9.
//  Copyright © 2017年 刘迪诗. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TNMenuView;

@protocol  TNMenuViewDelegate<NSObject>

- (NSInteger)menuViewNumberOfItems:(TNMenuView *)menuView;

- (UIView *)menuView:(TNMenuView *)menuView viewAtIndex:(NSInteger)index;

- (void)menuView:(TNMenuView *)menuView didSelectViewAtIndex:(NSInteger)index;

@end


@interface TNMenuView : UIView

@property (nonatomic, weak) id<TNMenuViewDelegate> delegate;

@property (nonatomic, assign) NSUInteger columnsCount;

@property (nonatomic, assign) CGFloat itemWidth;

@property (nonatomic,assign) BOOL showSliderView;

- (void)reloadData;

@end
