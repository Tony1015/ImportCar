//
//  TNIntroductionView.h
//  CFW_Cust
//
//  Created by tony on 16/5/17.
//  Copyright © 2016年 chefuwang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidSelectedEnter)();

typedef void (^DidClickImage)(NSInteger);

@interface TNIntroductionView : UIView

@property (nonatomic, strong) UIScrollView *pagingScrollView;
@property (nonatomic, strong) UIButton *enterButton;

@property (nonatomic, copy) DidSelectedEnter didSelectedEnter;

/**
 @[@"image1", @"image2"]
 */
@property (nonatomic, strong) NSArray *backgroundImageNames;

//set pageControl color
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;

@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;

//
@property (nonatomic,assign) BOOL autoCirculate;


@property (nonatomic,copy) DidClickImage didClickImageBlock;


/**
 @[@"coverImage1", @"coverImage2"]
 */
@property (nonatomic, strong) NSArray *coverImageNames;

- (instancetype)initWithFrame:(CGRect)frame coverNames:(NSArray *)coverNames;

- (instancetype)initWithFrame:(CGRect)frame coverNames:(NSArray *)coverNames backgroundImageNames:(NSArray *)bgNames;

- (instancetype)initWithFrame:(CGRect)frame coverNames:(NSArray *)coverNames backgroundImageNames:(NSArray *)bgNames button:(UIButton *)button;

@end
