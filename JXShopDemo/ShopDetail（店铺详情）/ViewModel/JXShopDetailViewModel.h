//
//  JXShopDetailViewModel.h
//  JXShopDemo
//
//  Created by mac on 17/6/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JXShopDetailInfo.h"

@interface JXShopDetailViewModel : NSObject

@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,assign) long shopId;

@property (nonatomic,strong) JXShopDetailInfo *shopInfo;
@property (nonatomic,strong) NSMutableArray *homeDataSource;
@property (nonatomic,strong) NSMutableArray *newsDataSource;
@property (nonatomic,strong) NSMutableArray *dymicDataSource;

@property (nonatomic,assign) int homeTotalPage;//推荐tab 当前的分页
@property (nonatomic,assign) int dymicTotalPage;//推荐tab 当前的分页
@property (nonatomic,assign) int newTotalPage;//上新tab 当前的分页

- (NSArray *)tabBarTitleArray;

- (NSArray *)tabBarTitleImageArray;

- (NSArray *)tabBarTitleSelImageArray;


- (void)refresh;


- (void)requestDefaultData;

- (void)requestShopDetail;

- (void)showTabActionAtIndex:(NSInteger)index;

@end
