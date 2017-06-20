//
//  JXShopDetailCollectionViewModel.h
//  JXShopDemo
//
//  Created by mac on 17/6/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXShopDetailCollectionViewModel : NSObject
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,assign) int pageNum;

- (void)refreshWithTag:(NSInteger)tag;

@end
