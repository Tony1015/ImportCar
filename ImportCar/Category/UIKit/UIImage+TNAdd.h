//
//  UIImage+TNAdd.h
//  BaseProject
//
//  Created by Tony on 2017/8/4.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TNAdd)

/**
 压缩图片至指定尺寸
 */
- (UIImage *)tn_imageChangeSizeTo:(CGSize)newSize;

/**
 压缩图片至 指定大小
 */
- (UIImage *)tn_imageChangeToStorageSize:(NSInteger)maxFileSize;


/**
 高斯模糊
 */
-(UIImage *)tn_coreBlurImageWithBlurNumber:(CGFloat)blur;

/**
 vImage模糊
 */
-(UIImage *)tn_boxblurImageWithBlurNumber:(CGFloat)blur;


/**
 改变图片颜色
 */
- (UIImage *)tn_changeImageColorTo:(UIColor *)color;


/**
 创建纯色图片
 */
+ (UIImage *)tn_creatImageWithColor:(UIColor *)color;

+ (UIImage *)tn_creatImageWithColor:(UIColor *)color withHeight:(CGFloat)height;


@end
