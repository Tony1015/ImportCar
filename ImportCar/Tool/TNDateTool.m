//
//  TNDateTool.m
//  anke
//
//  Created by Tony on 2017/9/5.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "TNDateTool.h"

@implementation TNDateTool


- (NSDate *)toDateFromDateStr:(NSString *)dateStr withDateFormat:(NSString *)dateFormat{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = dateFormat;
    return [formatter dateFromString:dateStr];
}

- (NSString *)toStringFromDate:(NSDate *)date withDateFormat:(NSString *)dateFormat{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = dateFormat;
    return [formatter stringFromDate:date];
}

- (NSString *)dateStr:(NSString *)dateStr changeToFormat:(NSString *)newFormat fromFormat:(NSString *)currentFormat{
    NSDate *date = [self toDateFromDateStr:dateStr withDateFormat:currentFormat];
    return [self toStringFromDate:date withDateFormat:newFormat];
}

@end
