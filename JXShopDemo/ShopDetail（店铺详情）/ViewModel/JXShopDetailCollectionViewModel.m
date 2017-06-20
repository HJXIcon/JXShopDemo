//
//  JXShopDetailCollectionViewModel.m
//  JXShopDemo
//
//  Created by mac on 17/6/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXShopDetailCollectionViewModel.h"

@implementation JXShopDetailCollectionViewModel

- (instancetype)init{
    self = [super init];
    if(self){
        _dataSource = [NSMutableArray array];
    }
    return self;
}


#pragma mark -
#pragma mark ---action
- (void)refreshWithTag:(NSInteger)tag{
    self.dataSource = nil;
    //    PUBLISH([[GMShopDetailRefreshEvent alloc]initWithTabIndex:tag subTabIndex:0]);
}

@end
