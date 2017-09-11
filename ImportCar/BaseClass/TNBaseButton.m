//
//  TNBaseButton.m
//  anke
//
//  Created by Tony on 2017/8/18.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "TNBaseButton.h"

@interface TNBaseButton ()

@property (nonatomic,copy) void(^afterLayoutSubviewsBlock)();

@end

@implementation TNBaseButton


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}


- (void)verticalCenterImageAndTitle:(CGFloat)spacing{
    @tnWeakify(self);
    self.afterLayoutSubviewsBlock = ^{
        @tnStrongify(self);
        CGSize imageSize = self.imageView.size;
        CGSize titleSize = self.titleLabel.size;
        
        if (imageSize.height + titleSize.height + 3*spacing > self.bounds.size.height) {
            imageSize.height = self.imageView.width = self.imageView.height = self.bounds.size.height - titleSize.height - 3*spacing;
        }
        self.imageView.y = (self.height - imageSize.height - titleSize.height - spacing)/2;
        self.imageView.centerX = self.boundsCenter.x;
        [self.titleLabel sizeToFit];
        self.titleLabel.y = CGRectGetMaxY(self.imageView.frame) + spacing;
        self.titleLabel.centerX = self.boundsCenter.x;
    };
}

- (void)verticalCenterImageAndTitle{
    [self verticalCenterImageAndTitle:0];
}


- (void)horizontalCenterTitleAndImage:(CGFloat)spacing{
    @tnWeakify(self);
    self.afterLayoutSubviewsBlock = ^{
        @tnStrongify(self);
        CGSize imageSize = self.imageView.size;
        CGSize titleSize = self.titleLabel.size;
        
        self.titleLabel.centerY = self.boundsCenter.y;
        self.titleLabel.x = (self.width - imageSize.width - titleSize.width - spacing)/2;
        self.imageView.centerY = self.boundsCenter.y;
        self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + spacing;
    };
}
- (void)horizontalCenterTitleAndImage{
    [self horizontalCenterTitleAndImage:0];
}

- (void)horizontalCenterImageAndTitle:(CGFloat)spacing{
    @tnWeakify(self);
    self.afterLayoutSubviewsBlock = ^{
        @tnStrongify(self);
        CGSize imageSize = self.imageView.size;
        CGSize titleSize = self.titleLabel.size;
        
        self.imageView.centerY = self.boundsCenter.y;
        self.imageView.x = (self.width - imageSize.width - titleSize.width - spacing)/2;
        self.titleLabel.centerY = self.boundsCenter.y;
        self.titleLabel.x = CGRectGetMaxX(self.imageView.frame) + spacing;
    };
}


//图片,文字在左边
- (void)horizontalLeftImageAndTitle:(CGFloat)spacing{
    @tnWeakify(self);
    self.afterLayoutSubviewsBlock = ^{
        @tnStrongify(self);
        
        self.imageView.centerY = self.boundsCenter.y;
        self.imageView.x = spacing;
        self.titleLabel.centerY = self.boundsCenter.y;
        self.titleLabel.x = CGRectGetMaxX(self.imageView.frame) + spacing;
    };
}

- (void)horizontalLeftImageAndTitle{
    [self horizontalLeftImageAndTitle:0];
}

//图片,文字在右边
- (void)horizontalRightImageAndTitle:(CGFloat)spacing{
    @tnWeakify(self);
    self.afterLayoutSubviewsBlock = ^{
        @tnStrongify(self);
        CGSize imageSize = self.imageView.size;
        CGSize titleSize = self.titleLabel.size;
        
        self.titleLabel.centerY = self.boundsCenter.y;
        self.titleLabel.x = self.width - titleSize.width - spacing;
        self.imageView.centerY = self.boundsCenter.y;
        self.imageView.x = self.titleLabel.x - imageSize.width - spacing;
    };
}

- (void)horizontalRightImageAndTitle{
    [self horizontalRightImageAndTitle:0];
}


- (void)onlyImageButtonSizeToFit{
    @tnWeakify(self);
    self.afterLayoutSubviewsBlock = ^{
        @tnStrongify(self);
        self.titleLabel.frame = CGRectZero;
        self.imageView.frame = self.bounds;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    };
}



- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.afterLayoutSubviewsBlock) {
        self.afterLayoutSubviewsBlock();
    }
}


@end
