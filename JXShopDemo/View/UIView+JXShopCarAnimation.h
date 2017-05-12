//
//  UIView+JXShopCarAnimation.h
//  JXAnimation
//
//  Created by mac on 16/11/24.
//  Copyright © 2016年 Mr.Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JXShopCarAnimation)<CAAnimationDelegate>

/**
 添加商品动画

 @param imageView 需要绘画的图层
 @param endPoint 终点
 @param toView 在那个view添加动画
 */
- (void)addProductsAnimation:(UIImageView *)imageView endPoint:(CGPoint)endPoint toView:(UIView *)toView ;

@end
