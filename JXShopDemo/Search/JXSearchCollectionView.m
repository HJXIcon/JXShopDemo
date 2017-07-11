//
//  JXSearchCollectionView.m
//  FishingWorld
//
//  Created by mac on 16/12/21.
//  Copyright © 2016年 zhuya. All rights reserved.
//

#import "JXSearchCollectionView.h"

/// UIScrollView的事件响应顺序跟一般的不同，一般的见参考文档， UIScrollView 的工作原理，当手指 touch 的时候， UIScrollView 会拦截 Event, 会等待一段时间，在这段时间内，如果没有手指没有移动，当时间结束时， UIScrollView 会发送 tracking events 到子视图上。在时间结束前，手指发生了移动，那么 UIScrollView 就会进行移动，从而取笑发送 tracking 顺序说明： 当手指 touch 的时候，如果 scrollView 上面有可交互的视图， track, －>或滑动或点击


@implementation JXSearchCollectionView
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
    // 备注：注意顺序，所以当 delaysContentTouches 为 no ， canCancelContentTouches 为 no 的时候， touchesShouldBegin 方法的返回值不同，滑动在 “ 可交互的视图 ” 的效果也不同，一个滑的动，一个滑不动 ( 注意是 touch move 了之后的事情 )
        
        self.delaysContentTouches = NO;
        // 就是手指点击到类的时候，如果它为 yes ，则按之前讲的处理，如果为 no ，并且点在了 “ 可交互的视图 ” ，立马调用 touchesShouldBegin
        self.canCancelContentTouches = YES;
        // 是 if touches have already been delivered to a subview of the scroll view 之后发生的事，如果 no ，即使 touch move ，也不 scroll 了，反之 如果是 yes ， tracking 后，手指移动，会调用 touchesShouldCancelInContentView 方法；
        
        UIView *wrapView = self.subviews.firstObject;
        
        if (wrapView != nil && [NSStringFromClass(wrapView.classForCoder) hasPrefix:@"WrapperView"]) {
            
            for (UIGestureRecognizer *gesture in wrapView.gestureRecognizers) {
                
                if ([NSStringFromClass(gesture.classForCoder) containsString:@"DelayedTouchesBegan"]) {
                    gesture.enabled = NO;
                    break;
                }
            }
        }
        
    }
    return self;
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view{
    if ([view isKindOfClass:[UIControl class]]) {
        return YES;
    }
    return [super touchesShouldCancelInContentView:view];
}


@end
