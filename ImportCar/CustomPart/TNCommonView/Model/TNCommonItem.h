//
//  TNCommonItem.h
//  BaseProject
//
//  Created by Tony on 2017/8/4.
//  Copyright © 2017年 Tony. All rights reserved.
//  一个cell对应一个TNCommonItem模型

#import <Foundation/Foundation.h>

@interface TNCommonItem : NSObject

/**
 *  图标
 */
@property(nonatomic,copy)NSString *icon;
/**文字信息 */
@property(nonatomic,copy)NSString *title;

/**
 *  详情
 */
@property(nonatomic,copy)NSString *subTitle;
/** 右边显示的数字标记 */
@property (nonatomic, copy) NSString *badgeValue;

/** 需要跳转的控制器类名 */
@property(nonatomic,assign)Class destinationClass;


/** 点击这个cell想做的操作 */
@property (nonatomic, copy) void (^operation)();



+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;
+ (instancetype)itemWithTitle:(NSString *)title;

-(void)setTitle:(NSString *)title;



@end
