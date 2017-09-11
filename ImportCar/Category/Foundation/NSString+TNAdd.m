//
//  NSString+TNAdd.m
//  BaseProject
//
//  Created by Tony on 2017/8/14.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "NSString+TNAdd.h"

@implementation NSString (TNAdd)

- (NSString *)tn_truncateByCharLength:(NSUInteger)charLength
{
    __block NSUInteger length = 0;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              
                              if ( length+substringRange.length > charLength )
                              {
                                  *stop = YES;
                                  return;
                              }
                              
                              length+=substringRange.length;
                          }];
    
    return [self substringToIndex:length];
}

+ (BOOL)tn_isEmptyString:(NSString *)string{
    if (!string) {
        return YES;
    }
    if (string.length == 0) {
        return YES;
    }
    return NO;
}

- (CGSize)tn_calculateSizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth{
    CGRect rect = [self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size;
}

@end
