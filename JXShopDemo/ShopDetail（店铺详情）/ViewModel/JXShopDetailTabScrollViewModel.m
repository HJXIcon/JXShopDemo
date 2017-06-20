//
//  JXShopDetailTabScrollViewModel.m
//  JXShopDemo
//
//  Created by mac on 17/6/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXShopDetailTabScrollViewModel.h"
#import "JXShopDetailUserCase.h"

@interface JXShopDetailTabScrollViewModel ()
@property (nonatomic,strong) JXShopDetailUserCase *uesrCase;
@property (nonatomic,assign) NSInteger commonTotalPage;//推荐tab 当前的分页
@property (nonatomic,assign) NSInteger salesTotalPage;//推荐tab 当前的分页
@property (nonatomic,assign) NSInteger priceTotalPage;//推荐tab 当前的分页
@property (nonatomic,assign) NSInteger newTotalPage;//推荐tab 当前的分页


@end
@implementation JXShopDetailTabScrollViewModel

- (instancetype)init{
    self = [super init];
    if(self){
        _commonTotalPage = 1;
        _salesTotalPage = 1;
        _newTotalPage = 1;
        _priceTotalPage = 1;
        _uesrCase = [[JXShopDetailUserCase alloc]init];
        [self loadDataRequestAtIndex:0 isLoadMore:false];
    }
    return self;
}

#pragma mark -
#pragma mark --- getter and setter
- (NSMutableArray *)tabBarTitleArray{
    return [NSMutableArray arrayWithObjects:@"综合",@"销量",@"新品",@"价格",nil];
}


- (NSMutableArray *)dataSourceAtIndex:(NSInteger)index{
    switch (index) {
        case LYShopDetailAllProduct_common:
        {
            return self.allCommonDataSource;
        }
            break;
        case LYShopDetailAllProduct_sales:
        {
            return self.allSalesDataSource;
        }
            break;
        case LYShopDetailAllProduct_price:
        {
            return self.allPriceDataSource;
        }
            break;
        case LYShopDetailAllProduct_new:
        {
            return self.allNewDataSource;
        }
            break;
            
        default:
            return nil;
            break;
    }
    
}

- (void)setDataSource:(NSArray *)array atIndex:(NSInteger)index isLoadMore:(BOOL)isLoadMore{
    switch (index) {
        case LYShopDetailAllProduct_common:
        {
            if(isLoadMore){
                if(!self.allCommonDataSource) self.allCommonDataSource = [NSMutableArray array];
                NSMutableArray *data = [NSMutableArray arrayWithArray:self.allCommonDataSource];
                [data addObjectsFromArray:array];
                self.allCommonDataSource = data;
            }else{
                self.allCommonDataSource = [NSMutableArray arrayWithArray:array];
            }
        }
            break;
        case LYShopDetailAllProduct_sales:
        {
            if(isLoadMore){
                if(!self.allSalesDataSource) self.allSalesDataSource = [NSMutableArray array];
                NSMutableArray *data = [NSMutableArray arrayWithArray:self.allSalesDataSource];
                [data addObjectsFromArray:array];
                self.allSalesDataSource = data;
            }else{
                self.allSalesDataSource = [NSMutableArray arrayWithArray:array];
            }
        }
            break;
        case LYShopDetailAllProduct_price:
        {
            if(isLoadMore){
                if(!self.allPriceDataSource) self.allPriceDataSource = [NSMutableArray array];
                NSMutableArray *data = [NSMutableArray arrayWithArray:self.allPriceDataSource];
                [data addObjectsFromArray:array];
                self.allPriceDataSource = data;
            }else{
                self.allPriceDataSource = [NSMutableArray arrayWithArray:array];
            }
        }
            break;
        case LYShopDetailAllProduct_new:
        {
            if(isLoadMore){
                if(!self.allNewDataSource) self.allNewDataSource = [NSMutableArray array];
                NSMutableArray *data = [NSMutableArray arrayWithArray:self.allNewDataSource];
                [data addObjectsFromArray:array];
                self.allNewDataSource = data;
            }else{
                self.allNewDataSource = [NSMutableArray arrayWithArray:array];
            }
        }
            break;
            
        default:
            break;
    }
    
}

- (void)setTotalPageAtIndex:(NSInteger)index totalPage:(NSInteger)totalPage{
    if(index == 0){
        self.commonTotalPage = totalPage;
    }else if (index == 1){
        self.salesTotalPage = totalPage;
    }else if (index == 2){
        self.priceTotalPage = totalPage;
    }else{
        self.newTotalPage = totalPage;
    }
}

- (NSInteger)getTotalPageAtIndex:(NSInteger)index{
    if(index == 0){
        return self.commonTotalPage;
    }else if (index == 1){
        return self.salesTotalPage;
    }else if (index == 2){
        return self.priceTotalPage;
    }else{
        return self.newTotalPage;
    }
}

#pragma mark -
#pragma mark --- request
- (void)loadDataRequestAtIndex:(NSInteger)index isLoadMore:(BOOL)isLoadMore{
    [self loadDataRequestAtIndex:index isLoadMore:isLoadMore isOrder:false];
}

- (void)loadDataRequestAtIndex:(NSInteger)index isLoadMore:(BOOL)isLoadMore isOrder:(BOOL)order{
    int currentPage = 0;
    if(isLoadMore){
        currentPage = (int)([self dataSourceAtIndex:index].count-1)/20+1;
    }else if([self dataSourceAtIndex:index].count>0 && index != 3){
        return;
    }
    [_uesrCase shopProductInfoRequestWithShopId:self.shopId type:index order:order pageNum:++currentPage pageSize:20 Success:^(NSArray *array) {
        [self setDataSource:array atIndex:index isLoadMore:isLoadMore];
    } fail:^(NSString *errorMsg) {
        //        self.toastMessage = errorMsg;
    }];
}

#pragma mark -
#pragma mark --- data convert
//- (NSMutableArray<GMBShopProductCollectionCellViewData *> *)transfromSearch:(NSArray<GMBItems*> *)data{
//    NSMutableArray *array = [NSMutableArray array];
//    for(GMBItems *items in data){
//        GMBShopProductCollectionCellViewData *vd = [[GMBShopProductCollectionCellViewData alloc]initWithProductID:items.id shopID:items.shopId productMainImage:items.mainImage productName:items.name productsalePrice:items.salePrice originalPrice:items.price isRebate:items.isRebate isDiscount:items.isDiscount onShelfAt:items.onShelfAt];
//        [array addObject:vd];
//    }
//    return array;
//}

@end
