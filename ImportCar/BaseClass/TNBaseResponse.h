//
//  TNBaseResponse.h
//  anke
//
//  Created by Tony on 2017/8/29.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TNBaseResponse : NSObject


/**
 调用状态：0成功，非0失败
 */
@property (nonatomic, copy) NSString *result;

/**
 描述：“成功”|失败原因
 */
@property (nonatomic, copy) NSString *msg;


- (void)judgeIfSuccess:(void(^)())success;

@end
