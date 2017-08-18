//
//  JXShopDetailScrollView.h
//  JXShopDemo
//
//  Created by mac on 17/6/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXShopDetailScrollView : UIScrollView

@property (nonatomic,strong,readonly) NSArray<UIView *> *subViews;
// tab切换
@property (nonatomic,copy) void (^tabBarSelBlock)(NSInteger index);
@property (nonatomic,copy) void (^translationBlock)(CGFloat offset);
@property (nonatomic,assign) BOOL couldScroll;

- (instancetype)initWithSubViews:(NSArray *)subViews;
- (void)showSubView:(NSInteger)index;

- (UIScrollView *)currentSubScorllView;
- (UIScrollView *)subScorllViewAtIndex:(NSInteger)index;

- (void)showNoNetWorkDefaultView;


@end
