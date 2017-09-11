//
//  TNMenuView.m
//  ImportCar
//
//  Created by Tony on 2017/9/9.
//  Copyright © 2017年 刘迪诗. All rights reserved.
//

#import "TNMenuView.h"

#define ViewBaseTag 1000

@interface TNMenuView ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, weak) UIButton *selectedBtn;

@property (nonatomic, weak) UIView *slideView;

@end

@implementation TNMenuView

static NSString *reuseId = @"menuReuseId";

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        self.collectionView = collectionView;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseId];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [self addSubview:collectionView];
        self.columnsCount = 1;
        self.itemWidth = 50;
        
        //滑块
        UIView *slideView = [[UIView alloc]init];
        slideView.backgroundColor = [UIColor redColor];
        self.slideView = slideView;
//        slideView.y = self.height - 2;
//        slideView.height = 2;
//        slideView.frame = CGRectMake(0, 0, 20, 20);
        slideView.hidden = !self.showSliderView;
        [self.collectionView addSubview:slideView];
        
    }
    return self;
}

- (void)setShowSliderView:(BOOL)showSliderView{
    _showSliderView = showSliderView;
    self.slideView.hidden = !showSliderView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.delegate menuViewNumberOfItems:self];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:reuseId forIndexPath:indexPath];
    UIView *view = [self.delegate menuView:self viewAtIndex:indexPath.row];
    view.tag = ViewBaseTag + indexPath.row;
    if ([view isKindOfClass:[UIButton class]]) {
        [(UIButton *)view addTarget:self action:@selector(clickedBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    [cell setValue:view forKey:@"contentView"];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.itemWidth, self.height/(CGFloat)self.columnsCount);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (void)clickedBtn:(UIButton *)sender{
    self.selectedBtn.selected = NO;
    sender.selected = YES;
    self.selectedBtn = sender;
    [self collectionView:self.collectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:sender.tag - ViewBaseTag inSection:0]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self slideViewScrollToIndexPath:indexPath withAnimation:YES];
    if ([self.delegate respondsToSelector:@selector(menuView:didSelectViewAtIndex:)]) {
        [self.delegate menuView:self didSelectViewAtIndex:indexPath.row];
    }
}

- (void)reloadData{
    [self.collectionView reloadData];
    UIView *view = [self.delegate menuView:self viewAtIndex:0];
    if ([view isKindOfClass:[UIButton class]]) {
        [self clickedBtn:(UIButton *)view];
    }else{
        [self collectionView:self.collectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }
}


- (void)slideViewScrollToIndexPath:(NSIndexPath *)indexPath withAnimation:(BOOL)animation{
    UIView *view = [self.collectionView cellForItemAtIndexPath:indexPath];
    
    //把点击的按钮滑到屏幕中间
    CGFloat offsetX = view.x - (tnScreenWidth - self.itemWidth)*0.5;
    CGFloat maxX = self.collectionView.contentSize.width;
    if (offsetX<0) {
        offsetX = 0;
    }else if(offsetX > maxX - tnScreenWidth){
        offsetX = maxX - tnScreenWidth;
    }
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    //滑块动画
    [UIView animateWithDuration:animation?0.5:0 animations:^{
        [self.slideView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(2);
            make.bottom.centerX.width.equalTo(view);
        }];
        [self.collectionView layoutIfNeeded];
    }];
}

#pragma mark ---UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGPoint point = scrollView.contentOffset;
    NSInteger count = round(point.x/self.itemWidth);
    [scrollView setContentOffset:CGPointMake(count*self.itemWidth, 0) animated:YES];
}

@end
