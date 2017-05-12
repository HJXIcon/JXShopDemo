//
//  UIScrollView+JXPage.m
//  JXShopDemo
//
//  Created by mac on 17/4/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "UIScrollView+JXPage.h"
#import <objc/runtime.h>
#import <MJRefresh/MJRefresh.h>


static const float kAnimationDuration = 0.25f;

static const char jx_originContentHeight;
static const char jx_secondScrollView;


@interface UIScrollView()

@property (nonatomic, assign) float originContentHeight;

@end



@implementation UIScrollView (JXPage)

#pragma mark - 关联属性
- (void)setOriginContentHeight:(float)originContentHeight {
    objc_setAssociatedObject(self, &jx_originContentHeight, @(originContentHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (float)originContentHeight {
    return [objc_getAssociatedObject(self, &jx_originContentHeight) floatValue];
}

- (UIScrollView *)secondScrollView {
    return objc_getAssociatedObject(self, &jx_secondScrollView);
}

- (void)setSecondScrollView:(UIScrollView *)secondScrollView {
    objc_setAssociatedObject(self, &jx_secondScrollView, secondScrollView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // 1.添加第一scrollView底部刷新
    [self addFirstScrollViewFooter];
    
    
    // 2.设置第二个scrollView的frame
    CGRect frame = self.bounds;
    frame.origin.y = self.contentSize.height + self.mj_footer.frame.size.height;
    secondScrollView.frame = frame;
    
    [self addSubview:secondScrollView];
    
    // 3.添加第二个头部刷新
    [self addSecondScrollViewHeader];
}

- (void)setFirstScrollView:(UIScrollView *)firstScrollView {
    [self addFirstScrollViewFooter];
}



- (void)addFirstScrollViewFooter {
    __weak __typeof(self) weakSelf = self;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf endFooterRefreshing];
    }];
    
    footer.triggerAutomaticallyRefreshPercent = 2;
    [footer setTitle:@"继续拖动,查看图文详情" forState:MJRefreshStateIdle];
    
    self.mj_footer = footer;
}

- (void)addSecondScrollViewHeader {
    __weak __typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf endHeaderRefreshing];
        
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"下拉,返回宝贝详情" forState:MJRefreshStateIdle];
    [header setTitle:@"释放,返回宝贝详情" forState:MJRefreshStatePulling];
    
    self.secondScrollView.mj_header = header;
}


- (void)endFooterRefreshing {
    [self.mj_footer endRefreshing];
    self.mj_footer.hidden = YES;
    self.scrollEnabled = NO;
    
    self.secondScrollView.mj_header.hidden = NO;
    self.secondScrollView.scrollEnabled = YES;
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.contentInset = UIEdgeInsetsMake(-self.contentSize.height - self.mj_footer.frame.size.height, 0, 0, 0);
    }];
    
    self.originContentHeight = self.contentSize.height;
    self.contentSize = self.secondScrollView.contentSize;
}

- (void)endHeaderRefreshing {
    [self.secondScrollView.mj_header endRefreshing];
    self.secondScrollView.mj_header.hidden = YES;
    self.secondScrollView.scrollEnabled = NO;
    
    self.scrollEnabled = YES;
    
    /// 判断当前控制器是否有导航条
    CGFloat topOffet = 0;
    if ([[self getCurrentVC] isKindOfClass:[UINavigationController class]]) {
        topOffet = 64;
    }
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.contentInset = UIEdgeInsetsMake(topOffet, 0, self.mj_footer.frame.size.height, 0);
    }];
    self.contentSize = CGSizeMake(0, self.originContentHeight);
    
    [self setContentOffset:CGPointZero animated:YES];
    
    [self addFirstScrollViewFooter];
}


/// 获取当前控制器
- (UIViewController *)getCurrentVC
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return  topController;
}




@end
