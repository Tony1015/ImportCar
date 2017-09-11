//
//  TNBaseButton.h
//  anke
//
//  Created by Tony on 2017/8/18.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TNBaseButton : UIButton

//上下居中，图片在上，文字在下
- (void)verticalCenterImageAndTitle:(CGFloat)spacing;
- (void)verticalCenterImageAndTitle;

//左右居中，文字在左，图片在右
- (void)horizontalCenterTitleAndImage:(CGFloat)spacing;
- (void)horizontalCenterTitleAndImage;

//左右居中，图片在左，文字在右
- (void)horizontalCenterImageAndTitle:(CGFloat)spacing;
//- (void)horizontalCenterImageAndTitle;

//图片,文字在左边
- (void)horizontalLeftImageAndTitle:(CGFloat)spacing;
- (void)horizontalLeftImageAndTitle;

//图片,文字在右边
- (void)horizontalRightImageAndTitle:(CGFloat)spacing;
- (void)horizontalRightImageAndTitle;


//图片按钮，图片自适应大小
- (void)onlyImageButtonSizeToFit;

@end
