//
//  TNDateTool.h
//  anke
//
//  Created by Tony on 2017/9/5.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TNDateTool : NSObject

/**
 从字符串到NSDate
 */
- (NSDate *)toDateFromDateStr:(NSString *)dateStr withDateFormat:(NSString *)dateFormat;

/**
 从NSDate到字符串
 */
- (NSString *)toStringFromDate:(NSDate *)date withDateFormat:(NSString *)dateFormat;

/**
 改变时间字符串的格式
 */
- (NSString *)dateStr:(NSString *)dateStr changeToFormat:(NSString *)newFormat fromFormat:(NSString *)currentFormat;



@end
