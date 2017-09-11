//
//  TNDataTool.h
//  BaseProject
//
//  Created by Tony on 2017/8/4.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TNDataTool : NSObject


/**
 字符串转数据（蓝牙传输）
 */
+ (NSData *)toBytesFromHexString:(NSString *)str;

/**
 10进制转16进制
 */
+ (NSString *)toHexStringFromBinary:(uint16_t)tmpid;

/**
 10进制转2进制
 */
+ (NSString *)toBinaryStringFromDecimal:(NSInteger)decimal;

/**
 MD5加密字符串
 */
+(NSString *)MD5EncodedFromString:(NSString *)content;
@end
