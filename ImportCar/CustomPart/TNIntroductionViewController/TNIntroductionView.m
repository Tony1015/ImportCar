//
//  TNIntroductionView.m
//  CFW_Cust
//
//  Created by tony on 16/5/17.
//  Copyright © 2016年 chefuwang. All rights reserved.
//

#import "TNIntroductionView.h"

#define CirculateInterval 3

#define BackGroundImageBaseTag 1000
#define CoverImageBaseTag 10000

@interface TNIntroductionView () <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *backgroundViews;
@property (nonatomic, strong) NSArray *scrollViewPages;
@property (nonatomic, strong) UIPageControl *pageControl;
//@property (nonatomic, assign) NSInteger centerPageIndex;

@property (nonatomic,weak) NSTimer *timer;

@end

@implementation TNIntroductionView


- (instancetype)initWithFrame:(CGRect)frame coverNames:(NSArray *)coverNames
{
    return [self initWithFrame:frame coverNames:coverNames backgroundImageNames:nil];
}

- (instancetype)initWithFrame:(CGRect)frame coverNames:(NSArray *)coverNames backgroundImageNames:(NSArray *)bgNames
{
    return [self initWithFrame:frame coverNames:coverNames backgroundImageNames:bgNames button:nil];
}

- (instancetype)initWithFrame:(CGRect)frame coverNames:(NSArray *)coverNames backgroundImageNames:(NSArray *)bgNames button:(UIButton *)button{
    
    if (self = [super initWithFrame:frame]) {
        self.coverImageNames = coverNames;
        self.backgroundImageNames = bgNames;
        self.enterButton = button;
        self.autoCirculate = NO;
        [self commonInit];
    }
    return self;
}

- (void)setAutoCirculate:(BOOL)autoCirculate{
    _autoCirculate = autoCirculate;
    [self reloadPages];
}


- (void)setCoverImageNames:(NSArray *)coverImageNames{
    _coverImageNames = coverImageNames;
    [self reloadPages];
}

- (void)commonInit {
//    [self addBackgroundViews];
    
    self.pagingScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.pagingScrollView.delegate = self;
    self.pagingScrollView.pagingEnabled = YES;
    self.pagingScrollView.showsHorizontalScrollIndicator = NO;
    self.pagingScrollView.showsVerticalScrollIndicator = NO;
    self.pagingScrollView.bounces = NO;
    
    [self addSubview:self.pagingScrollView];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:[self frameOfPageControl]];
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
//    if (self.pageIndicatorTintColor) {
//        self.pageControl.pageIndicatorTintColor = self.pageIndicatorTintColor;
//    }
//    if (self.currentPageIndicatorTintColor) {
//        self.pageControl.currentPageIndicatorTintColor = self.currentPageIndicatorTintColor;
//    }
    
    [self addSubview:self.pageControl];
    if (self.enterButton) {
        [self.enterButton addTarget:self action:@selector(enter:) forControlEvents:UIControlEventTouchUpInside];
        self.enterButton.frame = [self frameOfEnterButton];
        self.enterButton.width = 105;
        self.enterButton.height = 30;
        self.enterButton.centerX = self.centerX;
        self.enterButton.y = self.height*0.82;
        self.enterButton.alpha = 0;
        [self addSubview:self.enterButton];
    }
    [self reloadPages];
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor{
    _pageIndicatorTintColor = pageIndicatorTintColor;
    self.pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor{
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    self.pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}

- (void)addBackgroundViews
{
    CGRect frame = self.bounds;
    NSMutableArray *tmpArray = [NSMutableArray new];
    [[[[self backgroundImageNames] reverseObjectEnumerator] allObjects] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:obj]];
        imageView.frame = frame;
        imageView.tag = idx + BackGroundImageBaseTag;
        [tmpArray addObject:imageView];
        [self addSubview:imageView];
    }];
    self.backgroundViews = [[tmpArray reverseObjectEnumerator] allObjects];
}

- (void)reloadPages
{
    self.pageControl.numberOfPages = [[self coverImageNames] count];
    self.pagingScrollView.contentSize = [self contentSizeOfScrollView];
    
    [self.pagingScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    __block CGFloat x = 0;
    [[self scrollViewPages] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        obj.frame = CGRectOffset(obj.frame, x, 0);
        [self.pagingScrollView addSubview:obj];
        
        x += obj.frame.size.width;
    }];
    if (self.autoCirculate) {
        self.pagingScrollView.contentOffset = CGPointMake(self.width, 0);
        [self beginCirculate];
    }
    
    // fix enterButton can not presenting if ScrollView have only one page
    if (self.pageControl.numberOfPages == 1) {
        self.enterButton.alpha = 1;
        self.pageControl.alpha = 0;
    }
    
    // fix ScrollView can not scrolling if it have only one page
    if (self.pagingScrollView.contentSize.width == self.pagingScrollView.frame.size.width) {
        self.pagingScrollView.contentSize = CGSizeMake(self.pagingScrollView.contentSize.width + 1, 0);
    }
}

- (void)beginCirculate{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:CirculateInterval target:self selector:@selector(timerSchedule) userInfo:nil repeats:YES];
}

- (void)timerSchedule{
    [self.pagingScrollView setContentOffset:CGPointMake(self.pagingScrollView.contentOffset.x+self.width, 0) animated:YES];
}

- (void)stopCirculate{
    [self.timer invalidate];
}



- (CGRect)frameOfPageControl
{
    return CGRectMake(0, self.bounds.size.height - 30, self.bounds.size.width, 30);
}

- (CGRect)frameOfEnterButton
{
    CGSize size = self.enterButton.bounds.size;
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        size = CGSizeMake(self.frame.size.width * 0.6, 40);
    }
    return CGRectMake(self.frame.size.width / 2 - size.width / 2, self.pageControl.frame.origin.y - size.height, size.width, size.height);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSInteger index = scrollView.contentOffset.x / self.frame.size.width;
//    CGFloat alpha = 1 - ((scrollView.contentOffset.x - index * self.frame.size.width) / self.frame.size.width);
    
//    if ([self.backgroundViews count] > index) {
//        UIView *v = [self.backgroundViews objectAtIndex:index];
//        if (v) {
//            [v setAlpha:alpha];
//        }
//    }
    
    self.pageControl.currentPage = roundf(scrollView.contentOffset.x/self.width);
    
    if (self.autoCirculate) {
        NSInteger page = (int)(scrollView.contentOffset.x/self.width+0.5) - 1;
        self.pageControl.currentPage = page;
        
        
        if (scrollView.contentOffset.x == (self.coverImageNames.count + 1)*self.width) {
            scrollView.contentOffset = CGPointMake(self.width, 0);
        }else if(scrollView.contentOffset.x == 0){
            scrollView.contentOffset = CGPointMake(self.coverImageNames.count*self.width, 0);
        }
    }
    
    [self pagingScrollViewDidChangePages:scrollView];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (self.autoCirculate) {
        [self beginCirculate];
    }else{
        if ([scrollView.panGestureRecognizer translationInView:scrollView.superview].x < 0) {
            if (![self hasNext:self.pageControl]) {
                [self enter:nil];
            }
        }
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopCirculate];
}


#pragma mark - UIScrollView & UIPageControl DataSource

- (BOOL)hasNext:(UIPageControl*)pageControl
{
    return pageControl.numberOfPages > pageControl.currentPage + 1;
}

- (BOOL)isLast:(UIPageControl*)pageControl
{
    return pageControl.numberOfPages == pageControl.currentPage + 1;
}

- (NSInteger)numberOfPagesInPagingScrollView
{
    return [[self coverImageNames] count];
}

- (void)pagingScrollViewDidChangePages:(UIScrollView *)pagingScrollView
{
    if (self.autoCirculate) return;
    if ([self isLast:self.pageControl]) {
        if (self.pageControl.alpha == 1) {
            self.enterButton.alpha = 0;
            
            [UIView animateWithDuration:0.4 animations:^{
                self.enterButton.alpha = 1;
                self.pageControl.alpha = 0;
            }];
        }
    } else {
        if (self.pageControl.alpha == 0) {
            [UIView animateWithDuration:0.4 animations:^{
                self.enterButton.alpha = 0;
                self.pageControl.alpha = 1;
            }];
        }
    }
}

- (BOOL)hasEnterButtonInView:(UIView*)page
{
    __block BOOL result = NO;
    [page.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (obj && obj == self.enterButton) {
            result = YES;
        }
    }];
    return result;
}

- (UIImageView*)scrollViewPage:(NSString*)imageName
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.userInteractionEnabled = YES;
    imageView.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, self.width, self.height);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickedImageView:)];
    [imageView addGestureRecognizer:tap];
    return imageView;
}

- (void)clickedImageView:(UITapGestureRecognizer *)tap{
    
    if(self.didClickImageBlock){
        CGPoint point = [tap locationInView:self.pagingScrollView];
        NSInteger tag = point.x/self.width;
        if (self.autoCirculate) {
            if (tag == 0) {
                self.didClickImageBlock(self.coverImageNames.count-1);
            }else if (tag == self.scrollViewPages.count - 1){
                self.didClickImageBlock(0);
            }else{
                self.didClickImageBlock(tag-1);
            }
        }else{
            self.didClickImageBlock(tag);
        }
    }
}

- (NSArray*)scrollViewPages
{
    if ([self numberOfPagesInPagingScrollView] == 0) {
        return nil;
    }
    
//    if (_scrollViewPages) {
//        return _scrollViewPages;
//    }
    
    NSMutableArray *tmpArray = [NSMutableArray new];
    [self.coverImageNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        UIImageView *v = [self scrollViewPage:obj];
        [tmpArray addObject:v];
        
    }];
    
    if (self.autoCirculate) {
        [tmpArray addObject:[self scrollViewPage:self.coverImageNames[0]]];
        [tmpArray insertObject:[self scrollViewPage:self.coverImageNames[self.coverImageNames.count-1]] atIndex:0];
    }
    
    _scrollViewPages = tmpArray;
    
    for (int i = 0; i<_scrollViewPages.count; i++) {
        UIView *view = _scrollViewPages[i];
        view.tag = i+CoverImageBaseTag;
    }
    
    return _scrollViewPages;
}

- (CGSize)contentSizeOfScrollView
{
    UIView *view = [[self scrollViewPages] firstObject];
    
//    if(self.autoCirculate){
//        return CGSizeMake(view.frame.size.width * self.coverImageNames.count+1, 0);
//    }
    return CGSizeMake(view.frame.size.width * self.scrollViewPages.count, 0);
}

#pragma mark - Action

- (void)enter:(id)object
{
    if (self.didSelectedEnter) {
        self.didSelectedEnter();
    }
}



@end
