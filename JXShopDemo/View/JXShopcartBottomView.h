//
//  JXShopcartBottomView.h
//  JXShopDemo
//
//  Created by mac on 17/5/16.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JXShopcartBotttomViewAllSelectBlock)(BOOL isSelected);
typedef void(^JXShopcartBotttomViewSettleBlock)();
typedef void(^JXShopcartBotttomViewDeleteBlock)();

@interface JXShopcartBottomView : UIView
/// 全选
@property (nonatomic, copy) JXShopcartBotttomViewAllSelectBlock shopcartBotttomViewAllSelectBlock;
/// 结算
@property (nonatomic, copy) JXShopcartBotttomViewSettleBlock shopcartBotttomViewSettleBlock;

/// 删除
@property (nonatomic, copy) JXShopcartBotttomViewDeleteBlock shopcartBotttomViewDeleteBlock;


/// 初始化
- (void)configureShopcartBottomViewWithTotalPrice:(float)totalPrice
                                       totalCount:(NSInteger)totalCount
                                    isAllselected:(BOOL)isAllSelected;
/// 改变底部按钮状态
- (void)changeShopcartBottomViewWithStatus:(BOOL)status;


@end
