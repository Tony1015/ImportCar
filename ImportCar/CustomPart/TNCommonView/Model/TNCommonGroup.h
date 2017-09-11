//
//  TNCommonGroup.h
//  BaseProject
//
//  Created by Tony on 2017/8/4.
//  Copyright © 2017年 Tony. All rights reserved.
//

@class TNCommonItem;

@interface TNCommonGroup : NSObject

/** 头部标题 */
@property(nonatomic,copy)NSString *titleHead;
/** 尾部标题 */
@property(nonatomic,copy)NSString *titleFooter;
/** 这组的所有item模型 */
@property (nonatomic, strong) NSArray<TNCommonItem *> *items;

+ (instancetype)group;

+ (instancetype)groupWithItems:(NSArray<TNCommonItem *>*)items;

@end
