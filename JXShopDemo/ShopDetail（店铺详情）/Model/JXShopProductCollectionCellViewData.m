//
//  JXShopProductCollectionCellViewData.m
//  JXShopDemo
//
//  Created by mac on 17/6/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXShopProductCollectionCellViewData.h"

@implementation JXShopProductCollectionCellViewData

- (instancetype)initWithProductID:(long)id shopID:(long)shopId productMainImage:(NSString *)mainImage productName:(NSString *)name productsalePrice:(NSInteger)salePrice originalPrice:(NSInteger)originalPrice isRebate:(BOOL)isRebate isDiscount:(BOOL)isDiscount onShelfAt:(long long)onShelfAt
{
    self = [super init];
    if(self){
        _id = id;
        _shopId = shopId;
        _mainImage = mainImage;
        _name = name;
        _salePrice = salePrice;
        _originalPrice = originalPrice;
        _isRebate = isRebate;
        _isDiscount = isDiscount;
        _onShelfAt = onShelfAt/1000;
    }
    return  self;
}

+ (instancetype)testInfo{
    NSInteger price = (arc4random()+100000000)%100000;
    NSInteger originalPrice = (arc4random()+100000000)%100000;
    NSInteger index = (arc4random()+100)%100;
    JXShopProductCollectionCellViewData *data = [[JXShopProductCollectionCellViewData alloc]initWithProductID:0 shopID:0 productMainImage:@"4" productName:[NSString stringWithFormat:@"东京食尸鬼cosplay%ldIII",index] productsalePrice:price originalPrice:originalPrice isRebate:YES isDiscount:YES onShelfAt:5435345345345];
    return data;
}


@end
