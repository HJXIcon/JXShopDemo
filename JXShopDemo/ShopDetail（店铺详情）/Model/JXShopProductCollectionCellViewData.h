//
//  JXShopProductCollectionCellViewData.h
//  JXShopDemo
//
//  Created by mac on 17/6/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXShopProductCollectionCellViewData : NSObject
/**店铺id**/
@property (nonatomic,assign) long shopId;
/**商品id**/
@property (nonatomic,assign) long id;
/**商品主图**/
@property (nonatomic,copy) NSString  *mainImage;
/**商品名称**/
@property (nonatomic,copy) NSString  *name;
/**商品原价价格,对应BS字段(price)**/
@property (nonatomic,assign) NSInteger originalPrice;
/**商品售价*/
@property (nonatomic,assign) NSInteger salePrice;
/**是否返利*/
@property (nonatomic,assign) BOOL isRebate;
/**是否直降*/
@property (nonatomic,assign) BOOL isDiscount;
/**上架时间*/
@property (nonatomic,assign) long long onShelfAt;

- (instancetype)initWithProductID:(long)id
shopID:(long)shopId
productMainImage:(NSString *)mainImage
productName:(NSString *)name
productsalePrice:(NSInteger)salePrice
originalPrice:(NSInteger)originalPrice
isRebate:(BOOL)isRebate
isDiscount:(BOOL)isDiscount
onShelfAt:(long long)onShelfAt;

+ (instancetype)testInfo;

@end
