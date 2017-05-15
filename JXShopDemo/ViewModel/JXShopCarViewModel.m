//
//  JXShopCarViewModel.m
//  JXShopDemo
//
//  Created by mac on 17/4/21.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXShopCarViewModel.h"
#import "JXCartModel.h"


@interface JXShopCarViewModel(){
    
    NSArray *_shopGoodsCount; // 店铺下商品数据
    NSArray *_goodsPicArray; // 店铺下商品图片
    NSArray *_goodsPriceArray; // 店铺下商品价格
    NSArray *_goodsQuantityArray; // 店铺下商品数量数组
    
}

@end
@implementation JXShopCarViewModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _shopGoodsCount  = @[@(1),@(8),@(5),@(2),@(4),@(4)];
        _goodsPicArray  = @[
                            @"http://pic.5tu.cn/uploads/allimg/1606/pic_5tu_big_2016052901023305535.jpg",
                            @"http://pic.5tu.cn/uploads/allimg/1605/pic_5tu_big_2016052901023303745.jpg",
                            @"http://pic.5tu.cn/uploads/allimg/1605/pic_5tu_big_201605291711245481.jpg",
                            @"http://pic.5tu.cn/uploads/allimg/1605/pic_5tu_big_2016052901023285762.jpg",
                            @"http://pic.5tu.cn/uploads/allimg/1506/091630516760.jpg",
                            @"http://pic.5tu.cn/uploads/allimg/1506/091630516760.jpg"
                            ];
        _goodsPriceArray = @[@(30.45),@(120.09),@(7.8),@(11.11),@(56.1),@(12)];
        _goodsQuantityArray = @[@(12),@(21),@(1),@(10),@(3),@(5)];
    }
    
    
    return self;
}


#pragma mark - 网络加载数据

// 获取数据
- (void)getData{
    //数据个数
    NSInteger allCount = 20;
    NSInteger allGoodsCount = 0;
    NSMutableArray *storeArray = [NSMutableArray arrayWithCapacity:allCount];
    NSMutableArray *shopSelectAarry = [NSMutableArray arrayWithCapacity:allCount];
    
    //创造店铺数据
    for (int i = 0; i < allCount; i++) {
        
        //创造店铺下商品数据
        NSInteger goodsCount = [_shopGoodsCount[self.random] intValue];
        NSMutableArray *goodsArray = [NSMutableArray arrayWithCapacity:goodsCount];
        
        for (int x = 0; x < goodsCount; x++) {
            JXCartModel *cartModel = [[JXCartModel alloc] init];
            cartModel.p_id         = @"122115465400";
            cartModel.p_price      = [_goodsPriceArray[self.random] floatValue];
            cartModel.p_name       = [NSString stringWithFormat:@"%@这是一个很长很长的名字呀呀呀呀呀呀",@(x)];
            cartModel.p_stock      = 10;
            cartModel.p_imageUrl   = _goodsPicArray[self.random];
            cartModel.p_quantity   = [_goodsQuantityArray[self.random] integerValue];
            [goodsArray addObject:cartModel];
            allGoodsCount++;
        }
        
        [storeArray addObject:goodsArray];
        [shopSelectAarry addObject:@(NO)];
        
    }
    self.cartData = storeArray;
    self.shopSelectArray = shopSelectAarry;
    self.cartGoodsCount = allGoodsCount;
}


- (NSInteger)random{
    
    NSInteger from = 0;
    NSInteger to   = 5;
    
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
    
}




// 数量改变
- (void)rowChangeQuantity:(NSInteger)quantity
                indexPath:(NSIndexPath *)indexPath{
    
    NSInteger section  = indexPath.section;
    NSInteger row      = indexPath.row;
    
    JXCartModel *model = self.cartData[section][row];
    
    /// KVC
    [model setValue:@(quantity) forKey:@"p_quantity"];
    
    [self.cartTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    
    /*重新计算价格*/
    self.allPrices = [self getAllPrices];
    
}



//选中那个商品
- (void)rowSelect:(BOOL)isSelect
        IndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section          = indexPath.section;
    NSInteger row              = indexPath.row;
    
    NSMutableArray *goodsArray = self.cartData[section];
    NSInteger shopCount        = goodsArray.count;
    JXCartModel *model         = goodsArray[row];
    [model setValue:@(isSelect) forKey:@"isSelect"];
    
    //判断是都到达足够数量
    NSInteger isSelectShopCount = 0;
    for (JXCartModel *model in goodsArray) {
        if (model.isSelect) {
            isSelectShopCount++;
        }
    }
    
    [self.shopSelectArray replaceObjectAtIndex:section withObject:@(isSelectShopCount == shopCount ? YES : NO)];
    
    [self.cartTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    
    /*重新计算价格*/
    self.allPrices = [self getAllPrices];
    
}

//获取价格
- (float)getAllPrices{
    
    __block float allPrices   = 0;
    
    NSInteger shopCount       = self.cartData.count;
    NSInteger shopSelectCount = self.shopSelectArray.count;
    
    /// 判断是否全部选中
    if (shopSelectCount == shopCount && shopCount!=0) {
        self.isSelectAll = YES;
    }
    

    
    return allPrices;

}
@end
