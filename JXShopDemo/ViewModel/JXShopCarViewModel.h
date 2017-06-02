//
//  JXShopCarViewModel.h
//  JXShopDemo
//
//  Created by mac on 17/4/21.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class JXShopcartBrandModel;

@protocol JXShopcartFormatDelegate <NSObject>

@required

// 这是请求购物车列表成功之后的回调方法，将装有Model的数组回调到控制器；控制器将其赋给TableView的代理类JVShopcartTableViewProxy并刷新TableView。
- (void)shopcartFormatRequestProductListDidSuccessWithArray:(NSMutableArray *)dataArray;

// 这是用户在操作了单选、多选、全选、删除这些会改变底部结算视图里边的全选按钮状态、商品总价和商品数的统一回调方法，这条API会将用户操作之后的结果，也就是是否全选、商品总价和和商品总数回调给JVShopcartViewController， 控制器拿着这些数据调用底部结算视图BottomView的configure方法并刷新TableView，就完成了UI更新。
- (void)shopcartFormatAccountForTotalPrice:(float)totalPrice
                                totalCount:(NSInteger)totalCount
                             isAllSelected:(BOOL)isAllSelected;


/// 这是用户点击结算按钮的回调方法，这条API会将剔除了未选中ProductModel的模型数组回调给JVShopcartViewController，但并不改变原数据源因为用户随时可能返回
- (void)shopcartFormatSettleForSelectedProducts:(NSArray *)selectedProducts;

/// 这是用户删除了购物车所有数据之后的回调方法，你可能会做些视图的隐藏或者提示。
- (void)shopcartFormatWillDeleteSelectedProducts:(NSArray *)selectedProducts;
- (void)shopcartFormatHasDeleteAllProducts;

/// 点击店铺点跳转到店铺详情
- (void)shopcartFormatClickStoreName:(NSString *)storeID;

@end


@interface JXShopCarViewModel : NSObject


@property (nonatomic, strong) NSMutableArray <JXShopcartBrandModel *>*shopcartListArray;    /**< 购物车数据源 */

@property (nonatomic, weak) id <JXShopcartFormatDelegate> delegate;



/// 加载数据
- (void)requestShopcartProductList;

/// 选中商品
- (void)selectProductAtIndexPath:(NSIndexPath *)indexPath isSelected:(BOOL)isSelected;

/// 选中店铺
- (void)selectBrandAtSection:(NSInteger)section isSelected:(BOOL)isSelected;

/// 点击店铺
- (void)clickBrandAtSection:(NSInteger)section;


/// 数量改变
- (void)changeCountAtIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count;

/// 删除
- (void)deleteProductAtIndexPath:(NSIndexPath *)indexPath;
- (void)beginToDeleteSelectedProducts;
- (void)deleteSelectedProducts:(NSArray *)selectedArray;

/// 收藏
- (void)starProductAtIndexPath:(NSIndexPath *)indexPath;
- (void)starSelectedProducts;

/// 选中所有
- (void)selectAllProductWithStatus:(BOOL)isSelected;
- (void)settleSelectedProducts;


@end
