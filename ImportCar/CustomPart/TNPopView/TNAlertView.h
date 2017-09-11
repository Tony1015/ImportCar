//
//  TNAlertView.h
//  BaseProject
//
//  Created by Tony on 2017/8/13.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TNAlertInputHandler)(NSString *text);
@class TNAlertViewItem;

@interface TNAlertView : UIView
@property (nonatomic, assign) NSUInteger maxInputLength;


+ (instancetype)showWithInputTitle:(NSString*)title
                            detail:(NSString*)detail
                             items:(NSArray<TNAlertViewItem *> *)items
                       placeholder:(NSString*)inputPlaceholder
                           handler:(TNAlertInputHandler)inputHandler;

+  (instancetype)showWithTitle:(NSString*)title
                        detail:(NSString*)detail
                         items:(NSArray<TNAlertViewItem *> *)items;


- (instancetype) initWithInputTitle:(NSString*)title
                             detail:(NSString*)detail
                              items:(NSArray<TNAlertViewItem *> *)items
                        placeholder:(NSString*)inputPlaceholder
                            handler:(TNAlertInputHandler)inputHandler;

- (instancetype) initWithTitle:(NSString*)title
                        detail:(NSString*)detail
                         items:(NSArray<TNAlertViewItem *> *)items;



@end

typedef NS_ENUM (NSInteger, TNAlertViewItemStyle) {
    TNAlertViewItemStyleNormal,
    TNAlertViewItemStyleCancel,
    TNAlertViewItemStyleDestructive,
};


typedef void(^TNAlertViewItemHandler)();

@interface TNAlertViewItem : NSObject

@property (copy, nonatomic, readonly) NSString *title;

@property (assign, nonatomic, readonly) TNAlertViewItemStyle style;

@property (nonatomic,copy) TNAlertViewItemHandler handler;



+ (instancetype)itemWithTitle:(NSString *)title style:(TNAlertViewItemStyle)style handler:(TNAlertViewItemHandler)handler;


@end
