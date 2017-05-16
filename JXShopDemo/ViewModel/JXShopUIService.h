//
//  JXShopUIService.h
//  JXShopDemo
//
//  Created by mac on 17/4/21.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class JXShopCarViewModel;

typedef void(^JXShopcartProxyProductSelectBlock)(BOOL isSelected, NSIndexPath *indexPath);

typedef void(^JXShopcartProxyBrandSelectBlock)(BOOL isSelected, NSInteger section);

typedef void(^JXShopcartProxyChangeCountBlock)(NSInteger count, NSIndexPath *indexPath);

typedef void(^JXShopcartProxyDeleteBlock)(NSIndexPath *indexPath);

typedef void(^JXShopcartProxyStarBlock)(NSIndexPath *indexPath);


@interface JXShopUIService : NSObject<UITableViewDelegate,UITableViewDataSource>

/// 负责购物车逻辑处理
@property (nonatomic, strong) JXShopCarViewModel *viewModel;

/// 选中商品
@property (nonatomic, copy) JXShopcartProxyProductSelectBlock shopcartProxyProductSelectBlock;

/// 选中店铺
@property (nonatomic, copy) JXShopcartProxyBrandSelectBlock shopcartProxyBrandSelectBlock;

/// 数量改变
@property (nonatomic, copy) JXShopcartProxyChangeCountBlock shopcartProxyChangeCountBlock;

/// 删除
@property (nonatomic, copy) JXShopcartProxyDeleteBlock shopcartProxyDeleteBlock;

/// 收藏
@property (nonatomic, copy) JXShopcartProxyStarBlock shopcartProxyStarBlock;


@end
