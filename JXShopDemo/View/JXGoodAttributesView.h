//
//  JXGoodAttributesView.h
//  JXShopDemo
//
//  Created by mac on 17/4/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXGoodAttrModel;
/**
 商品属性View
 */
@interface JXGoodAttributesView : UIView

/** 属性值数组 */
@property (nonatomic, strong) NSArray <JXGoodAttrModel *> *goodAttrsArr;

/// 回调
@property (nonatomic, copy) void (^sureBtnsClickBlock)(NSString *num, NSString *goods_id);

@property (nonatomic, copy) void (^closeBlock)();


@end
