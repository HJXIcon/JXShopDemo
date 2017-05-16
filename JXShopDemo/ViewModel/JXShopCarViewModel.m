//
//  JXShopCarViewModel.m
//  JXShopDemo
//
//  Created by mac on 17/4/21.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXShopCarViewModel.h"
#import "JXShopcartBrandModel.h"
#import <MJExtension/MJExtension.h>
#import "JXShopcartProductModel.h"


@interface JXShopCarViewModel()


@end

@implementation JXShopCarViewModel
/// 加载数据
- (void)requestShopcartProductList{
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"shopcart" ofType:@"plist"];
    NSMutableArray *dataArray = [NSMutableArray arrayWithContentsOfFile:plistPath];
    self.shopcartListArray = [JXShopcartBrandModel mj_objectArrayWithKeyValuesArray:dataArray];
    
    //成功之后回调
    [self.delegate shopcartFormatRequestProductListDidSuccessWithArray:self.shopcartListArray];
}


/// 用户选中了某个产品或某个row的处理方法，因为这会改变底部结算视图所以一定会回调上文协议中的第二个方法。
- (void)selectProductAtIndexPath:(NSIndexPath *)indexPath isSelected:(BOOL)isSelected {
    JXShopcartBrandModel *brandModel = self.shopcartListArray[indexPath.section];
    JXShopcartProductModel *productModel = brandModel.products[indexPath.row];
    productModel.isSelected = isSelected;
    
    BOOL isBrandSelected = YES;
    
    for (JXShopcartProductModel *aProductModel in brandModel.products) {
        if (aProductModel.isSelected == NO) {
            isBrandSelected = NO;
        }
    }
    
    brandModel.isSelected = isBrandSelected;
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
}



/// 用户选中了某个品牌或某个section的处理方法
- (void)selectBrandAtSection:(NSInteger)section isSelected:(BOOL)isSelected {
    JXShopcartBrandModel *brandModel = self.shopcartListArray[section];
    brandModel.isSelected = isSelected;
    
    for (JXShopcartProductModel *aProductModel in brandModel.products) {
        aProductModel.isSelected = brandModel.isSelected;
    }
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
}



/// 这是用户改变了商品数量的处理方法
- (void)changeCountAtIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count {
    JXShopcartBrandModel *brandModel = self.shopcartListArray[indexPath.section];
    JXShopcartProductModel *productModel = brandModel.products[indexPath.row];
    if (count <= 0) {
        count = 1;
    } else if (count > productModel.productStocks) {
        count = productModel.productStocks;
    }
    
    //根据请求结果决定是否改变数据
    productModel.productQty = count;
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
}


/// 删除操作
- (void)deleteProductAtIndexPath:(NSIndexPath *)indexPath {
    JXShopcartBrandModel *brandModel = self.shopcartListArray[indexPath.section];
    JXShopcartProductModel *productModel = brandModel.products[indexPath.row];
    
    // 根据请求结果决定是否删除
    [brandModel.products removeObject:productModel];
    if (brandModel.products.count == 0) {
        [self.shopcartListArray removeObject:brandModel];
        
    } else {
        if (!brandModel.isSelected) {
            BOOL isBrandSelected = YES;
            for (JXShopcartProductModel *aProductModel in brandModel.products) {
                if (!aProductModel.isSelected) {
                    isBrandSelected = NO;
                    break;
                }
            }
            
            if (isBrandSelected) {
                brandModel.isSelected = YES;
            }
        }
    }
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
    
    /// 删除全部
    if (self.shopcartListArray.count == 0) {
        [self.delegate shopcartFormatHasDeleteAllProducts];
    }
}


- (void)beginToDeleteSelectedProducts {
    NSMutableArray *selectedArray = [[NSMutableArray alloc] init];
    for (JXShopcartBrandModel *brandModel in self.shopcartListArray) {
        for (JXShopcartProductModel *productModel in brandModel.products) {
            if (productModel.isSelected) {
                [selectedArray addObject:productModel];
            }
        }
    }
    
    [self.delegate shopcartFormatWillDeleteSelectedProducts:selectedArray];
}

// 批量删除
- (void)deleteSelectedProducts:(NSArray *)selectedArray {
    //网络请求
    //根据请求结果决定是否批量删除
    NSMutableArray *emptyArray = [[NSMutableArray alloc] init];
    for (JXShopcartBrandModel *brandModel in self.shopcartListArray) {
        [brandModel.products removeObjectsInArray:selectedArray];
        
        if (brandModel.products.count == 0) {
            [emptyArray addObject:brandModel];
        }
    }
    
    if (emptyArray.count) {
        [self.shopcartListArray removeObjectsInArray:emptyArray];
    }
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
    
    if (self.shopcartListArray.count == 0) {
        [self.delegate shopcartFormatHasDeleteAllProducts];
    }
}



/// 收藏
- (void)starProductAtIndexPath:(NSIndexPath *)indexPath {
    //这里写收藏的网络请求
    
}

- (void)starSelectedProducts {
    //这里写批量收藏的网络请求
    
}


/// 全选操作
- (void)selectAllProductWithStatus:(BOOL)isSelected {
    for (JXShopcartBrandModel *brandModel in self.shopcartListArray) {
        brandModel.isSelected = isSelected;
        for (JXShopcartProductModel *productModel in brandModel.products) {
            productModel.isSelected = isSelected;
        }
    }
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
}

/// 结算
- (void)settleSelectedProducts {
    NSMutableArray *settleArray = [[NSMutableArray alloc] init];
    for (JXShopcartBrandModel *brandModel in self.shopcartListArray) {
        NSMutableArray *selectedArray = [[NSMutableArray alloc] init];
        for (JXShopcartProductModel *productModel in brandModel.products) {
            if (productModel.isSelected) {
                [selectedArray addObject:productModel];
            }
        }
        
        brandModel.selectedArray = selectedArray;
        
        if (selectedArray.count) {
            [settleArray addObject:brandModel];
        }
    }
    
    [self.delegate shopcartFormatSettleForSelectedProducts:settleArray];
}

#pragma  mark - 私有方法
/// 计算总价
- (float)accountTotalPrice {
    float totalPrice = 0.f;
    for (JXShopcartBrandModel *brandModel in self.shopcartListArray) {
        for (JXShopcartProductModel *productModel in brandModel.products) {
            if (productModel.isSelected) {
                totalPrice += productModel.productPrice * productModel.productQty;
            }
        }
    }
    
    return totalPrice;
}

/// 商品数量
- (NSInteger)accountTotalCount {
    NSInteger totalCount = 0;
    
    for (JXShopcartBrandModel *brandModel in self.shopcartListArray) {
        for (JXShopcartProductModel *productModel in brandModel.products) {
            if (productModel.isSelected) {
                totalCount += productModel.productQty;
            }
        }
    }
    
    return totalCount;
}

/// 判断该店铺的商品是否全部选中
- (BOOL)isAllSelected {
    if (self.shopcartListArray.count == 0) return NO;
    
    BOOL isAllSelected = YES;
    
    for (JXShopcartBrandModel *brandModel in self.shopcartListArray) {
        if (brandModel.isSelected == NO) {
            isAllSelected = NO;
        }
    }
    
    return isAllSelected;
}


@end
