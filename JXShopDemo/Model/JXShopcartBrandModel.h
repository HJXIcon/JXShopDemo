//
//  JXShopcartBrandModel.h
//  JXShopDemo
//
//  Created by mac on 17/5/16.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JXShopcartProductModel.h"

/**
 店铺model
 */
@interface JXShopcartBrandModel : NSObject


@property (nonatomic, copy) NSString *brandId;

@property (nonatomic, strong) NSMutableArray<JXShopcartProductModel *> *products;

@property (nonatomic, copy) NSString *brandName;


#pragma mark 自定义
@property (nonatomic, assign)BOOL isSelected; //记录相应section是否全选

@property (nonatomic, strong) NSMutableArray *selectedArray;    //结算时筛选出选中的商品



@end
