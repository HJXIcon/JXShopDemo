//
//  JXShopDetailUserCase.m
//  JXShopDemo
//
//  Created by mac on 17/6/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXShopDetailUserCase.h"
#import "JXShopProductCollectionCellViewData.h"

@implementation JXShopDetailUserCase

- (void)shopInfoRequestWithShopId:(long)shopId
                          Success:(void(^)(JXShopDetailInfo *))successBlock
                             fail:(void(^)(NSString *errorMsg))failBlock{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        JXShopDetailInfo *info = [JXShopDetailInfo testInfo];
        successBlock(info);
    });
}

- (void)shopProductInfoRequestWithShopId:(long)shopId
                                    type:(NSInteger)type
                                   order:(BOOL)isDesc
                                 pageNum:(NSInteger)pageNum
                                pageSize:(NSInteger)pageSize
                                 Success:(void(^)(NSArray *))successBlock
                                    fail:(void(^)(NSString *errorMsg))failBlock{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableArray *array = [NSMutableArray array];
        for(int i=0;i<pageSize;i++){
            JXShopProductCollectionCellViewData *data = [JXShopProductCollectionCellViewData testInfo];
            [array addObject:data];
        }
        successBlock(array);
    });
}

@end
