//
//  JXShopCarViewModel.m
//  JXShopDemo
//
//  Created by mac on 17/4/21.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXShopCarViewModel.h"
#import "JXCartModel.h"
#import <ReactiveObjC/ReactiveObjC.h>

@implementation JXShopCarViewModel


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

//获取价格
- (float)getAllPrices{
    
    __block float allPrices   = 0;
    
    NSInteger shopCount       = self.cartData.count;
    NSInteger shopSelectCount = self.shopSelectArray.count;
    
    /// 判断是否全部选中
    if (shopSelectCount == shopCount && shopCount!=0) {
        self.isSelectAll = YES;
    }
    
    
    // RACSequence:RAC中的集合类，用于代替NSArray,NSDictionary,可以使用它来快速遍历数组和字典
    /*!
     // 这里其实是三步
     // 第一步: 把数组转换成集合RACSequence numbers.rac_sequence
     // 第二步: 把集合RACSequence转换RACSignal信号类,numbers.rac_sequence.signal
     // 第三步: 订阅信号，激活信号，会自动把集合中的所有值，遍历出来
     */
    
    NSArray *pricesArray = [[[self.cartData rac_sequence] map:^id(NSMutableArray *value) {
        
        // map:映射的意思，目的：把原始值value映射成一个新值
        // array: 把集合转换成数组
        // 底层实现：当信号被订阅，会遍历集合中的原始值，映射成新值，并且保存到新的数组里。
        
        /// filter：过滤
        return [[[value rac_sequence] filter:^BOOL(JXCartModel *model) {
            
            if (!model.isSelect) {
                self.isSelectAll = NO;
            }
            
            return model.isSelect;
            
        }] map:^id(JXCartModel *model) {
            
            return @(model.p_quantity *model.p_price);
        }];
        
    }] array];
    
    for (NSArray *priceA in pricesArray) {
        for (NSNumber *price in priceA) {
            allPrices += price.floatValue;
        }
    }
    
    return allPrices;

}
@end
