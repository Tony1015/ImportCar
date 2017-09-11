//
//  UIView+TNAdd.m
//  BaseProject
//
//  Created by Tony on 2017/8/4.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "UIView+TNAdd.h"

@implementation UIView (TNAdd)

#pragma mark - UIView + Frame
- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height{
    return self.frame.size.height;
}
- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size =size;
    self.frame =frame;
}
- (CGSize)size{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin{
    return self.frame.origin;
}

-(void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    
    center.x = centerX;
    
    self.center = center;
}
-(CGFloat)centerX{
    return self.center.x;
    
}

-(void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
-(CGFloat)centerY{
    return self.center.y;
    
}

- (CGPoint)boundsCenter{
    return CGPointMake(self.width*0.5, self.height*0.5);
}

- (void)setBoundsCenter:(CGPoint)boundsCenter{
}



- (UIViewController *)tn_getViewController{
    UIResponder *target = self;
    while (target) {
        target = target.nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return (UIViewController *)target;
}



- (UIImage*)tn_screenshot{
    UIGraphicsBeginImageContext(self.bounds.size);
    if( [self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)] ){
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    }else{
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // hack, helps w/ our colors when blurring
    NSData *imageData = UIImageJPEGRepresentation(image, 1); // convert to jpeg
    image = [UIImage imageWithData:imageData];
    return image;
}





@end
