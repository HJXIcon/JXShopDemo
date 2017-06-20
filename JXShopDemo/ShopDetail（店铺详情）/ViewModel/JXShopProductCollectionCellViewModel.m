//
//  JXShopProductCollectionCellViewModel.m
//  JXShopDemo
//
//  Created by mac on 17/6/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXShopProductCollectionCellViewModel.h"


@implementation JXShopProductCollectionCellViewModel


- (instancetype)init{
    self = [super init];
    if(self){
        _viewData = [[JXShopProductCollectionCellViewData alloc]init];
    }
    return self;
}
- (void)bindViewData:(id)data{
    _viewData = data;
}


@end
