//
//  JXShopCarViewModel.h
//  JXShopDemo
//
//  Created by mac on 17/4/21.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class JXShopCarViewController;

@interface JXShopCarViewModel : NSObject


@property (nonatomic, weak) JXShopCarViewController *cartVC;
@property (nonatomic, strong) NSMutableArray       *cartData;
@property (nonatomic, weak  ) UITableView          *cartTableView;

/**
 *  存放店铺选中
 */
@property (nonatomic, strong) NSMutableArray       *shopSelectArray;

/**
 *  总价 观察的属性变化
 */
@property (nonatomic, assign) float                 allPrices;

/**
 *  carbar 全选的状态
 */
@property (nonatomic, assign) BOOL                  isSelectAll;
/**
 *  购物车商品数量
 */
@property (nonatomic, assign) NSInteger             cartGoodsCount;

/**
 *  当前所选商品数量
 */
@property (nonatomic, assign) NSInteger             currentSelectCartGoodsCount;

//获取数据
- (void)getData;

//全选
- (void)selectAll:(BOOL)isSelect;

//选中那个商品
- (void)rowSelect:(BOOL)isSelect
        IndexPath:(NSIndexPath *)indexPath;


// 数量改变
- (void)rowChangeQuantity:(NSInteger)quantity
                indexPath:(NSIndexPath *)indexPath;

//获取价格
- (float)getAllPrices;

//左滑删除商品
- (void)deleteGoodsBySingleSlide:(NSIndexPath *)path;

//选中删除
- (void)deleteGoodsBySelect;



@end
