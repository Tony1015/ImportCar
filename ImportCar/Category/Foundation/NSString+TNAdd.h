//
//  NSString+TNAdd.h
//  BaseProject
//
//  Created by Tony on 2017/8/14.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TNAdd)


/**
 截取长度
 */
- (NSString *)tn_truncateByCharLength:(NSUInteger)charLength;

/**
 判断空字符串
 */
+ (BOOL)tn_isEmptyString:(NSString *)string;

/**
 计算字符串的尺寸大小
 */
- (CGSize)tn_calculateSizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;


@end
