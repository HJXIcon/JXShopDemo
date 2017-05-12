//
//  UIView+JXShopCarAnimation.m
//  JXAnimation
//
//  Created by mac on 16/11/24.
//  Copyright © 2016年 Mr.Gao. All rights reserved.
//

#import "UIView+JXShopCarAnimation.h"

static UIView *_toView;
static NSMutableArray *_animationLayers;

@implementation UIView (JXShopCarAnimation)


// 商品添加到购物车动画
- (void)addProductsAnimation:(UIImageView *)imageView endPoint:(CGPoint)endPoint toView:(UIView *)toView {
    
    if (_animationLayers == nil) {
        
        _animationLayers = [NSMutableArray array];
    }
    _toView = toView;
    // 坐标转变
    CGRect frame = [imageView convertRect:imageView.bounds toView:toView];
    CALayer *transitionLayer = [[CALayer alloc]init];
    transitionLayer.frame = frame;
    // 内容
    transitionLayer.contents = imageView.layer.contents;
    [toView.layer addSublayer:transitionLayer];
    [_animationLayers addObject:transitionLayer];
    
    
    CGPoint p1 = transitionLayer.position;
    //    CGPoint p3 = CGPointMake(self.view.frame.size.width - self.view.frame.size.width / 4 - self.view.frame.size.width / 8 - 6 , self.view.layer.bounds.size.height - 40);
    CGPoint p3 = endPoint;
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    struct CGPath *path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, p1.x, p1.y);
    CGPathAddCurveToPoint(path, nil, p1.x, p1.y - 30, p3.x, p1.y - 30, p3.x, p3.y);
    positionAnimation.path = path;
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @(1);
    opacityAnimation.toValue = @(0.9);
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.removedOnCompletion = YES;
    
    
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 1)];
    
    CAAnimationGroup *groupAnimation = [[CAAnimationGroup alloc]init];
    groupAnimation.animations = @[positionAnimation, transformAnimation, opacityAnimation];
    groupAnimation.duration = 0.8;
    groupAnimation.delegate = self;
    
    [transitionLayer addAnimation:groupAnimation forKey:@"cartParabola"];
    
    
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim{
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    if (_animationLayers.count > 0) {
        
        CALayer *transitionLayer = _animationLayers[0];
        transitionLayer.hidden = YES;
        [transitionLayer removeFromSuperlayer];
        [_animationLayers removeObjectAtIndex:0];
        [_toView.layer removeAnimationForKey:@"cartParabola"];
    }
    _animationLayers = nil;
    _toView = nil;
}

@end
