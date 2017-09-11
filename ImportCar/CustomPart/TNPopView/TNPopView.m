//
//  TNPopView.m
//  BlueTooth
//
//  Created by Tony on 2017/5/31.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "TNPopView.h"
#import <Accelerate/Accelerate.h>
#import <QuartzCore/QuartzCore.h>
#import <Masonry.h>
#import "UIImage+TNAdd.h"


#define AnimationDuration 0.25

typedef void(^TNPopViewAnimationBlock)();


@interface TNPopView ()
@property (nonatomic,weak) UIImageView *coverBlurView;

@property (nonatomic,copy) TNPopViewAnimationBlock showAnimation;

@property (nonatomic,copy) TNPopViewAnimationBlock dismissAnimation;

@property (nonatomic,weak) UIView *containerView;

@end

@implementation TNPopView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:CGRectNull]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    self.clickDismiss = YES;
//    self.backgroundColor = TNColor(255, 255, 255, 0.2);
//    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    UIVisualEffectView *view = [[UIVisualEffectView alloc]initWithEffect:effect];
//    view.frame = self.bounds;
//    [self addSubview:view];
    [self updateSubviews];
}

+ (instancetype)popViewWithContentView:(UIView *)contentView withClickDismiss:(BOOL)clickDismiss withAnimation:(TNPopViewAnimation)animation{
    TNPopView *view = [self popViewWithContentView:contentView withAnimation:animation];
    view.clickDismiss = clickDismiss;
    return view;
}

+ (instancetype)popViewWithContentView:(UIView *)contentView withClickDismiss:(BOOL)clickDismiss{
    TNPopView *view = [self popViewWithContentView:contentView];
    view.clickDismiss = clickDismiss;
    return view;
}

+ (instancetype)popViewWithContentView:(UIView *)contentView withAnimation:(TNPopViewAnimation)animation{
    TNPopView *view = [TNPopView popViewWithContentView:contentView];
    view.animation = animation;
    return view;
}

+ (instancetype)showPopViewWithContentView:(UIView *)contentView{
    TNPopView *view = [self popViewWithContentView:contentView];
    [view show];
    return view;
}

+ (instancetype)popViewWithContentView:(UIView *)contentView{
    TNPopView *view = [[TNPopView alloc]init];
    view.contentView = contentView;
    view.animation = TNPopViewAnimationNull;
    return view;
}
- (void)setContentView:(UIView *)contentView{
    if (_contentView!=contentView) {
        [_contentView removeFromSuperview];
        _contentView = contentView;
        CGFloat height = contentView.height;
        CGFloat width = contentView.width;
        if (height!=0 && width!=0) {
            [contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(width);
                make.height.mas_equalTo(height);
            }];
        }
        [self addSubview:_contentView];
    }
}

- (void)setAnimation:(TNPopViewAnimation)animation{
    _animation = animation;
    @tnWeakify(self);
    if (animation == TNPopViewAnimationFromRight) {
        self.showAnimation = ^{
            @tnStrongify(self);
            [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.centerX.equalTo(self).offset((self.contentView.width+tnAppWindow.width)/2);
            }];
            [self layoutIfNeeded];
            self.coverBlurView.alpha = 0.0f;
            [UIView animateWithDuration:AnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionBeginFromCurrentState animations:^{
                [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(self);
                }];
                [self layoutIfNeeded];
                self.coverBlurView.alpha = 1.0f;
            }completion:^(BOOL finished) {
                if (self.showComletionBlock) {
                    self.showComletionBlock();
                }
            }];
        };
        self.dismissAnimation = ^{
            @tnStrongify(self);
            [UIView animateWithDuration:AnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionBeginFromCurrentState animations:^{
                [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(self).offset((self.contentView.width+tnAppWindow.width)/2);
                }];
                [self layoutIfNeeded];
                self.coverBlurView.alpha = 0.0f;
            }completion:^(BOOL finished) {
                if (self.dismissComletionBlock) {
                    self.dismissComletionBlock();
                }
                [self removeFromSuperview];
                self.contentView = nil;
                [self.contentView removeFromSuperview];
            }];
        };
    }else if (animation == TNPopViewAnimationFromBottom){
        self.showAnimation = ^{
            @tnStrongify(self);
            [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.centerY.equalTo(self).offset((tnAppWindow.height+self.contentView.height)/2);
            }];
            [self layoutIfNeeded];
            self.coverBlurView.alpha = 0.0f;
            
            [UIView animateWithDuration:AnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionBeginFromCurrentState animations:^{
                [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self);
                }];
                [self layoutIfNeeded];
                self.coverBlurView.alpha = 1.0f;
            }completion:^(BOOL finished) {
                if (self.showComletionBlock) {
                    self.showComletionBlock();
                }
            }];
        };
        self.dismissAnimation = ^{
            @tnStrongify(self);
            [UIView animateWithDuration:AnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionBeginFromCurrentState animations:^{
                [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self).offset((tnAppWindow.height+self.contentView.height)/2);
                }];
                self.coverBlurView.alpha = 0.0f;
                [self layoutIfNeeded];
            }completion:^(BOOL finished) {
                if (self.dismissComletionBlock) {
                    self.dismissComletionBlock();
                }
                [self removeFromSuperview];
                self.contentView = nil;
                [self.contentView removeFromSuperview];
            }];
        };
    }else if (animation == TNPopViewAnimationNull){
        self.showAnimation = ^{
            @tnStrongify(self);
            [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self);
            }];
            [self layoutIfNeeded];
            self.alpha = 0.0f;
            self.contentView.layer.transform = CATransform3DMakeScale(1.3f, 1.3f, 1.0f);
            [UIView animateWithDuration:AnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionBeginFromCurrentState animations:^{
                [self layoutIfNeeded];
                self.contentView.layer.transform = CATransform3DIdentity;
                self.alpha = 1.0f;
            }completion:^(BOOL finished) {
                if (self.showComletionBlock) {
                    self.showComletionBlock();
                }
            }];
        };
        self.dismissAnimation = ^{
            @tnStrongify(self);
            [UIView animateWithDuration:AnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionBeginFromCurrentState animations:^{
//                self.coverBlurView.alpha = 0.0f;
                self.alpha = 0.0f;
                [self layoutIfNeeded];
            }completion:^(BOOL finished) {
                if (self.dismissComletionBlock) {
                    self.dismissComletionBlock();
                }
                [self removeFromSuperview];
                self.contentView = nil;
                [self.contentView removeFromSuperview];
            }];
        };
    }
}

- (void)show{
    [self showWithCompletion:nil];
}

- (void)showWithCompletion:(TNPopAnimationCompletionBlock)block{
    if (block) {
        self.showComletionBlock = block;
    }
    if (!self.superview) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(tnAppWindow);
        }];
    }
    self.showAnimation();
}

- (void)updateSubviews{
    UIImage *image = (UIImage *)[[UIApplication sharedApplication].keyWindow tn_screenshot];
    UIImageView *coverBlurView = [[UIImageView alloc]initWithImage:[image tn_boxblurImageWithBlurNumber:0.2]];
    [self addSubview:coverBlurView];
//    coverBlurView.alpha = 0;
    self.coverBlurView = coverBlurView;
//    UIView *containerView = [[UIView alloc]init];
//    self.containerView = containerView;
//    [self addSubview:containerView];
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self clickedDismiss];
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    return [super hitTest:point withEvent:event];
}

- (void)clickedDismiss{
    if (self.clickDismiss) {
        [self dismiss];
    }
}

- (void)dismissWithCompletion:(TNPopAnimationCompletionBlock)block{
    if(block){
        self.dismissComletionBlock = block;
    }
    self.dismissAnimation();
}

- (void)dismiss{
    [self dismissWithCompletion:nil];
}


@end

